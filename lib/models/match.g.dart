// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      id: (json['id'] as num).toInt(),
      competition: json['competition'] as String,
      season: json['season'] as String,
      utcDate: DateTime.parse(json['utcDate'] as String),
      status: json['status'] as String,
      matchday: (json['matchday'] as num).toInt(),
      stage: json['stage'] as String,
      group: json['group'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      homeTeam: Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
      awayTeam: Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
      score: Score.fromJson(json['score'] as Map<String, dynamic>),
      events: (json['events'] as List<dynamic>)
          .map((e) => MatchEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: json['statistics'] == null
          ? null
          : MatchStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'id': instance.id,
      'competition': instance.competition,
      'season': instance.season,
      'utcDate': instance.utcDate.toIso8601String(),
      'status': instance.status,
      'matchday': instance.matchday,
      'stage': instance.stage,
      'group': instance.group,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'score': instance.score,
      'events': instance.events,
      'statistics': instance.statistics,
    };

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      winner: json['winner'] as String,
      duration: json['duration'] as String,
      fullTime: FullTime.fromJson(json['fullTime'] as Map<String, dynamic>),
      halfTime: HalfTime.fromJson(json['halfTime'] as Map<String, dynamic>),
      extraTime: json['extraTime'] == null
          ? null
          : ExtraTime.fromJson(json['extraTime'] as Map<String, dynamic>),
      penalties: json['penalties'] == null
          ? null
          : Penalties.fromJson(json['penalties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'winner': instance.winner,
      'duration': instance.duration,
      'fullTime': instance.fullTime,
      'halfTime': instance.halfTime,
      'extraTime': instance.extraTime,
      'penalties': instance.penalties,
    };

FullTime _$FullTimeFromJson(Map<String, dynamic> json) => FullTime(
      home: (json['home'] as num?)?.toInt(),
      away: (json['away'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FullTimeToJson(FullTime instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

HalfTime _$HalfTimeFromJson(Map<String, dynamic> json) => HalfTime(
      home: (json['home'] as num?)?.toInt(),
      away: (json['away'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HalfTimeToJson(HalfTime instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

ExtraTime _$ExtraTimeFromJson(Map<String, dynamic> json) => ExtraTime(
      home: (json['home'] as num?)?.toInt(),
      away: (json['away'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExtraTimeToJson(ExtraTime instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

Penalties _$PenaltiesFromJson(Map<String, dynamic> json) => Penalties(
      home: (json['home'] as num?)?.toInt(),
      away: (json['away'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PenaltiesToJson(Penalties instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) => MatchEvent(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      team: json['team'] as String,
      player: json['player'] as String,
      minute: (json['minute'] as num?)?.toInt(),
      description: json['description'] as String?,
      eventType: json['eventType'] as String?,
    );

Map<String, dynamic> _$MatchEventToJson(MatchEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'team': instance.team,
      'player': instance.player,
      'minute': instance.minute,
      'description': instance.description,
      'eventType': instance.eventType,
    };

MatchStatistics _$MatchStatisticsFromJson(Map<String, dynamic> json) =>
    MatchStatistics(
      homeTeam: json['homeTeam'] as String,
      awayTeam: json['awayTeam'] as String,
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => Statistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchStatisticsToJson(MatchStatistics instance) =>
    <String, dynamic>{
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'statistics': instance.statistics,
    };

Statistic _$StatisticFromJson(Map<String, dynamic> json) => Statistic(
      type: json['type'] as String,
      home: (json['home'] as num).toInt(),
      away: (json['away'] as num).toInt(),
    );

Map<String, dynamic> _$StatisticToJson(Statistic instance) => <String, dynamic>{
      'type': instance.type,
      'home': instance.home,
      'away': instance.away,
    };
