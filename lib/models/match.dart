import 'package:json_annotation/json_annotation.dart';
import 'team.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  final int id;
  final String competition;
  final String season;
  final DateTime utcDate;
  final String status;
  final int matchday;
  final String stage;
  final String group;
  final DateTime lastUpdated;
  final Team homeTeam;
  final Team awayTeam;
  final Score score;
  final List<MatchEvent> events;
  final MatchStatistics? statistics;

  const Match({
    required this.id,
    required this.competition,
    required this.season,
    required this.utcDate,
    required this.status,
    required this.matchday,
    required this.stage,
    required this.group,
    required this.lastUpdated,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.events,
    this.statistics,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);

  bool get isLive => status == 'IN_PLAY' || status == 'PAUSED';
  bool get isFinished => status == 'FINISHED';
  bool get isScheduled => status == 'SCHEDULED' || status == 'TIMED';
}

@JsonSerializable()
class Score {
  final String winner;
  final String duration;
  final FullTime fullTime;
  final HalfTime halfTime;
  final ExtraTime? extraTime;
  final Penalties? penalties;

  const Score({
    required this.winner,
    required this.duration,
    required this.fullTime,
    required this.halfTime,
    this.extraTime,
    this.penalties,
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}

@JsonSerializable()
class FullTime {
  final int? home;
  final int? away;

  const FullTime({this.home, this.away});

  factory FullTime.fromJson(Map<String, dynamic> json) => _$FullTimeFromJson(json);
  Map<String, dynamic> toJson() => _$FullTimeToJson(this);
}

@JsonSerializable()
class HalfTime {
  final int? home;
  final int? away;

  const HalfTime({this.home, this.away});

  factory HalfTime.fromJson(Map<String, dynamic> json) => _$HalfTimeFromJson(json);
  Map<String, dynamic> toJson() => _$HalfTimeToJson(this);
}

@JsonSerializable()
class ExtraTime {
  final int? home;
  final int? away;

  const ExtraTime({this.home, this.away});

  factory ExtraTime.fromJson(Map<String, dynamic> json) => _$ExtraTimeFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraTimeToJson(this);
}

@JsonSerializable()
class Penalties {
  final int? home;
  final int? away;

  const Penalties({this.home, this.away});

  factory Penalties.fromJson(Map<String, dynamic> json) => _$PenaltiesFromJson(json);
  Map<String, dynamic> toJson() => _$PenaltiesToJson(this);
}

@JsonSerializable()
class MatchEvent {
  final int id;
  final String type;
  final String team;
  final String player;
  final int? minute;
  final String? description;
  final String? eventType;

  const MatchEvent({
    required this.id,
    required this.type,
    required this.team,
    required this.player,
    this.minute,
    this.description,
    this.eventType,
  });

  factory MatchEvent.fromJson(Map<String, dynamic> json) => _$MatchEventFromJson(json);
  Map<String, dynamic> toJson() => _$MatchEventToJson(this);
}

@JsonSerializable()
class MatchStatistics {
  final String homeTeam;
  final String awayTeam;
  final List<Statistic> statistics;

  const MatchStatistics({
    required this.homeTeam,
    required this.awayTeam,
    required this.statistics,
  });

  factory MatchStatistics.fromJson(Map<String, dynamic> json) => _$MatchStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchStatisticsToJson(this);
}

@JsonSerializable()
class Statistic {
  final String type;
  final int home;
  final int away;

  const Statistic({
    required this.type,
    required this.home,
    required this.away,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => _$StatisticFromJson(json);
  Map<String, dynamic> toJson() => _$StatisticToJson(this);
}

