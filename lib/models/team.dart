import 'package:json_annotation/json_annotation.dart';
import 'player.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;
  final String address;
  final String website;
  final int founded;
  final String clubColors;
  final String venue;
  final List<Player>? squad;
  final TeamStatistics? statistics;

  const Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    required this.address,
    required this.website,
    required this.founded,
    required this.clubColors,
    required this.venue,
    this.squad,
    this.statistics,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class TeamStatistics {
  final String competition;
  final String season;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;
  final int position;

  const TeamStatistics({
    required this.competition,
    required this.season,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
    required this.position,
  });

  factory TeamStatistics.fromJson(Map<String, dynamic> json) => _$TeamStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamStatisticsToJson(this);
}

