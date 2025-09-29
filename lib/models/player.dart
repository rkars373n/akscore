import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  final int id;
  final String name;
  final String position;
  final DateTime dateOfBirth;
  final String nationality;
  final String? shirtNumber;
  final String? role;
  final PlayerStatistics? statistics;

  const Player({
    required this.id,
    required this.name,
    required this.position,
    required this.dateOfBirth,
    required this.nationality,
    this.shirtNumber,
    this.role,
    this.statistics,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  int get age {
    final now = DateTime.now();
    return now.year - dateOfBirth.year;
  }
}

@JsonSerializable()
class PlayerStatistics {
  final String competition;
  final String season;
  final int appearances;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final int minutesPlayed;
  final double rating;

  const PlayerStatistics({
    required this.competition,
    required this.season,
    required this.appearances,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.minutesPlayed,
    required this.rating,
  });

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) => _$PlayerStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatisticsToJson(this);
}

