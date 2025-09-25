import 'package:isar/isar.dart';
import './team.dart';
import '../utils/json_utils.dart';

part 'match.g.dart';

enum MatchEventType {
  goal,
  yellowCard,
  redCard,
  substitution,
}

@embedded
class MatchStatistics {
  int? shotsHome;
  int? shotsAway;
  int? shotsOnTargetHome;
  int? shotsOnTargetAway;
  int? possessionHome;
  int? possessionAway;
  int? passesHome;
  int? passesAway;
  int? foulsHome;
  int? foulsAway;
  int? yellowCardsHome;
  int? yellowCardsAway;
  int? redCardsHome;
  int? redCardsAway;

  MatchStatistics();

  void fromJson(Map<String, dynamic> json) {
    shotsHome = safeGetInt(json, ['home', 'shots']);
    shotsAway = safeGetInt(json, ['away', 'shots']);
    shotsOnTargetHome = safeGetInt(json, ['home', 'shotsOnTarget']);
    shotsOnTargetAway = safeGetInt(json, ['away', 'shotsOnTarget']);
    possessionHome = safeGetInt(json, ['home', 'possession']);
    possessionAway = safeGetInt(json, ['away', 'possession']);
    passesHome = safeGetInt(json, ['home', 'passes']);
    passesAway = safeGetInt(json, ['away', 'passes']);
    foulsHome = safeGetInt(json, ['home', 'fouls']);
    foulsAway = safeGetInt(json, ['away', 'fouls']);
    yellowCardsHome = safeGetInt(json, ['home', 'yellowCards']);
    yellowCardsAway = safeGetInt(json, ['away', 'yellowCards']);
    redCardsHome = safeGetInt(json, ['home', 'redCards']);
    redCardsAway = safeGetInt(json, ['away', 'redCards']);
  }
}

@collection
class Match {
  Id dbId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;
  final homeTeam = IsarLink<Team>();
  final awayTeam = IsarLink<Team>();
  late int goalsHome;
  late int goalsAway;
  late String status;
  late DateTime matchTime;
  late String league;
  late String leagueLogo;
  late String venue;
  late String referee;
  final events = <MatchEvent>[];
  final statistics = MatchStatistics();
  late bool isLive;
  int? minute;

  Match();

  factory Match.fromJson(Map<String, dynamic> json) {
    final match = Match()
      ..id = json['id']?.toString() ?? ''
      ..goalsHome = safeGetInt(json, ['score', 'fullTime', 'home'])
      ..goalsAway = safeGetInt(json, ['score', 'fullTime', 'away'])
      ..status = _mapStatus(json['status'])
      ..matchTime = DateTime.parse(json['utcDate'] ?? DateTime.now().toIso8601String())
      ..league = json['competition']?['name'] ?? ''
      ..leagueLogo = json['competition']?['emblem'] ?? ''
      ..venue = json['venue'] ?? ''
      ..referee = (json['referees'] as List<dynamic>? ?? []).isNotEmpty ? json['referees'][0]['name'] : 'N/A'
      ..isLive = json['status'] == 'IN_PLAY' || json['status'] == 'LIVE'
      ..minute = json['minute'] as int?;

    if (json.containsKey('statistics')) {
      match.statistics.fromJson(json['statistics']);
    }

    match.events.addAll(_parseEvents(json));
    
    // The homeTeam and awayTeam IsarLinks will be populated manually after creation.

    return match;
  }

  static List<MatchEvent> _parseEvents(Map<String, dynamic> data) {
    final List<MatchEvent> events = [];
    final goals = data['goals'] as List<dynamic>? ?? [];
    final bookings = data['bookings'] as List<dynamic>? ?? [];
    final substitutions = data['substitutions'] as List<dynamic>? ?? [];

    for (final goal in goals) {
      events.add(MatchEvent.fromJson(goal));
    }

    for (final booking in bookings) {
      events.add(MatchEvent.fromJson(booking));
    }

    for (final sub in substitutions) {
      events.add(MatchEvent.fromJson(sub));
    }

    events.sort((a, b) => (a.minute ?? 0).compareTo(b.minute ?? 0));
    return events;
  }

  static String _mapStatus(String? status) {
    switch (status) {
      case 'IN_PLAY':
      case 'LIVE':
        return 'live';
      case 'FINISHED':
        return 'finished';
      case 'SCHEDULED':
      case 'TIMED':
        return 'scheduled';
      default:
        return 'scheduled';
    }
  }
}

@embedded
class MatchEvent {
  @Enumerated(EnumType.name)
  MatchEventType? type;
  String? player;
  String? assist;
  String? teamName;
  int? minute;

  MatchEvent();

  factory MatchEvent.fromJson(Map<String, dynamic> json) {
    final event = MatchEvent();
    event.type = _parseEventType(json);
    event.player = json['scorer']?['name'] ?? json['playerOut']?['name'] ?? json['player']?['name'] ?? '';
    event.assist = json['assist']?['name'];
    event.teamName = json['team']?['name'] ?? '';
    event.minute = safeGetInt(json, ['minute']);
    return event;
  }

  static MatchEventType _parseEventType(Map<String, dynamic> json) {
    if (json.containsKey('scorer')) {
      return MatchEventType.goal;
    } else if (json.containsKey('playerOut')) {
      return MatchEventType.substitution;
    } else if (json.containsKey('card')) {
      if (json['card'] == 'YELLOW_CARD') {
        return MatchEventType.yellowCard;
      } else {
        return MatchEventType.redCard;
      }
    }
    return MatchEventType.goal;
  }
}
