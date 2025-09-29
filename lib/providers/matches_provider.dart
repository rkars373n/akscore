import 'dart:async';
import 'package:flutter/material.dart';
import '../models/match.dart';
import '../services/real_api_service.dart';
import '../config/api_config.dart';
import '../services/realtime_service.dart';

class MatchesProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService(
    footballDataApiKey: ApiConfig.footballDataApiKey,
    rapidApiKey: ApiConfig.rapidApiKey,
  );
  final RealtimeService _realtimeService = RealtimeService();
  StreamSubscription? _matchSubscription;

  List<Match> _liveMatches = [];
  List<Match> _todayMatches = [];
  List<Match> _dateRangeMatches = [];
  final List<Match> _favoriteMatches = [];
  bool _isLoading = false;
  String? _error;
  DateTimeRange? _dateRange;

  List<Match> get liveMatches => _liveMatches;
  List<Match> get todayMatches => _todayMatches;
  List<Match> get dateRangeMatches => _dateRangeMatches;
  List<Match> get favoriteMatches => _favoriteMatches;
  bool get isLoading => _isLoading;
  String? get error => _error;
  DateTimeRange? get dateRange => _dateRange;

  MatchesProvider() {
    _matchSubscription = _realtimeService.matchUpdates.listen((match) {
      _updateLiveMatch(match);
    });
  }

  Future<void> loadLiveMatches() async {
    _setLoading(true);
    try {
      _liveMatches = await _apiService.getLiveMatches();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loadTodayMatches() async {
    _setLoading(true);
    try {
      _todayMatches = await _apiService.getTodayMatches();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loadMatchesForDateRange(DateTimeRange dateRange) async {
    _setLoading(true);
    _dateRange = dateRange;
    try {
      _dateRangeMatches = await _apiService.getMatchesForDateRange(dateRange);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void _updateLiveMatch(Match match) {
    final index = _liveMatches.indexWhere((m) => m.id == match.id);
    if (index != -1) {
      _liveMatches[index] = match;
      notifyListeners();
    }
  }

  void addToFavorites(Match match) {
    if (!_favoriteMatches.any((m) => m.id == match.id)) {
      _favoriteMatches.add(match);
      notifyListeners();
    }
  }

  void removeFromFavorites(Match match) {
    _favoriteMatches.removeWhere((m) => m.id == match.id);
    notifyListeners();
  }

  bool isFavorite(Match match) {
    return _favoriteMatches.any((m) => m.id == match.id);
  }

  @override
  void dispose() {
    _matchSubscription?.cancel();
    super.dispose();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
