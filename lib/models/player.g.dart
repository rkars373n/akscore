// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      position: json['position'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'] as String,
      shirtNumber: json['shirtNumber'] as String?,
      role: json['role'] as String?,
      statistics: json['statistics'] == null
          ? null
          : PlayerStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'nationality': instance.nationality,
      'shirtNumber': instance.shirtNumber,
      'role': instance.role,
      'statistics': instance.statistics,
    };

PlayerStatistics _$PlayerStatisticsFromJson(Map<String, dynamic> json) =>
    PlayerStatistics(
      competition: json['competition'] as String,
      season: json['season'] as String,
      appearances: (json['appearances'] as num).toInt(),
      goals: (json['goals'] as num).toInt(),
      assists: (json['assists'] as num).toInt(),
      yellowCards: (json['yellowCards'] as num).toInt(),
      redCards: (json['redCards'] as num).toInt(),
      minutesPlayed: (json['minutesPlayed'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$PlayerStatisticsToJson(PlayerStatistics instance) =>
    <String, dynamic>{
      'competition': instance.competition,
      'season': instance.season,
      'appearances': instance.appearances,
      'goals': instance.goals,
      'assists': instance.assists,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
      'minutesPlayed': instance.minutesPlayed,
      'rating': instance.rating,
    };
