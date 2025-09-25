import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/match.dart';
import 'notification_service.dart';

class RealtimeService {
  static final RealtimeService _instance = RealtimeService._internal();
  factory RealtimeService() => _instance;
  RealtimeService._internal();

  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  final List<String> _subscribedMatches = [];
  final NotificationService _notificationService = NotificationService();

  final _matchUpdateController = StreamController<Match>.broadcast();
  Stream<Match> get matchUpdateStream => _matchUpdateController.stream;

  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnected) return;
    _channel = IOWebSocketChannel.connect('wss://echo.websocket.events');
    _isConnected = true;
    _startListening();
  }

  void _startListening() {
    _channel?.stream.listen(
      (data) {
        final decoded = json.decode(data);
        if (decoded is Map<String, dynamic> && _subscribedMatches.contains(decoded['match_id'])) {
          final match = Match.fromJson(decoded);
          _matchUpdateController.add(match);
          final event = decoded['event'];
          if (event is String) {
            _handleNotification(match, event, decoded);
          }
        }
      },
      onDone: () {
        _isConnected = false;
        _reconnectTimer = Timer(const Duration(seconds: 5), connect);
      },
      onError: (error) {
        _isConnected = false;
        _reconnectTimer = Timer(const Duration(seconds: 5), connect);
      },
    );
  }

  Future<void> _handleNotification(Match match, String event, Map<String, dynamic> data) async {
    final setting = await _notificationService.getNotificationSetting(event);
    if (setting is bool && setting) {
      final homeTeamName = data['homeTeam']?['name'] ?? 'Home';
      final awayTeamName = data['awayTeam']?['name'] ?? 'Away';
      
      switch (event) {
        case 'goal':
          await _notificationService.showGoalNotification(
            matchId: match.id,
            homeTeam: homeTeamName,
            awayTeam: awayTeamName,
            scorer: match.events.last.player ?? 'N/A',
            minute: match.minute ?? 0,
            team: match.events.last.teamName ?? 'N/A',
          );
          break;
        case 'match_started':
          await _notificationService.showMatchStartNotification(
            matchId: match.id,
            homeTeam: homeTeamName,
            awayTeam: awayTeamName,
            league: match.league,
          );
          break;
        case 'match_ended':
          await _notificationService.showMatchEndNotification(
            matchId: match.id,
            homeTeam: homeTeamName,
            awayTeam: awayTeamName,
            homeScore: match.goalsHome,
            awayScore: match.goalsAway,
          );
          break;
        default:
          return;
      }
    }
  }

  Future<void> subscribeToMatch(String matchId) async {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(json.encode({'type': 'subscribe', 'match_id': matchId}));
      if (!_subscribedMatches.contains(matchId)){
        _subscribedMatches.add(matchId);
      }
    } else {
      // Handle the case where the connection is not established
      // Maybe queue the subscription and process it upon connection
    }
  }

  Future<void> unsubscribeFromMatch(String matchId) async {
    if (_channel != null && _isConnected) {
      _channel!.sink.add(json.encode({'type': 'unsubscribe', 'match_id': matchId}));
      _subscribedMatches.remove(matchId);
    } else {
      // Handle the case where the connection is not established
    }
  }

  Future<void> disconnect() async {
    _isConnected = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _channel?.sink.close();
    _matchUpdateController.close();
  }
}
