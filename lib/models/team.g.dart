// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      tla: json['tla'] as String,
      crest: json['crest'] as String,
      address: json['address'] as String,
      website: json['website'] as String,
      founded: (json['founded'] as num).toInt(),
      clubColors: json['clubColors'] as String,
      venue: json['venue'] as String,
      squad: (json['squad'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: json['statistics'] == null
          ? null
          : TeamStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'tla': instance.tla,
      'crest': instance.crest,
      'address': instance.address,
      'website': instance.website,
      'founded': instance.founded,
      'clubColors': instance.clubColors,
      'venue': instance.venue,
      'squad': instance.squad,
      'statistics': instance.statistics,
    };

TeamStatistics _$TeamStatisticsFromJson(Map<String, dynamic> json) =>
    TeamStatistics(
      competition: json['competition'] as String,
      season: json['season'] as String,
      played: (json['played'] as num).toInt(),
      won: (json['won'] as num).toInt(),
      drawn: (json['drawn'] as num).toInt(),
      lost: (json['lost'] as num).toInt(),
      goalsFor: (json['goalsFor'] as num).toInt(),
      goalsAgainst: (json['goalsAgainst'] as num).toInt(),
      goalDifference: (json['goalDifference'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$TeamStatisticsToJson(TeamStatistics instance) =>
    <String, dynamic>{
      'competition': instance.competition,
      'season': instance.season,
      'played': instance.played,
      'won': instance.won,
      'drawn': instance.drawn,
      'lost': instance.lost,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
      'goalDifference': instance.goalDifference,
      'points': instance.points,
      'position': instance.position,
    };
