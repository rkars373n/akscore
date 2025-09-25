import 'package:isar/isar.dart';
import '../utils/json_utils.dart';
import './player.dart';

part 'team.g.dart';

@collection
class Team {
  Id dbId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;
  late String name;
  late String logo;
  late String country;
  late String league;
  late int founded;
  late String stadium;
  late int capacity;
  late String coach;
  final stats = TeamStats();

  @Backlink(to: "team")
  final players = IsarLinks<Player>();

  Team();

  factory Team.fromJson(Map<String, dynamic> json) {
    final teamData = json.containsKey('team') ? json['team'] : json;
    final venueData = json.containsKey('venue') ? json['venue'] : {};

    final team = Team()
      ..id = teamData['id']?.toString() ?? ''
      ..name = teamData['name'] ?? ''
      ..logo = teamData['logo'] ?? teamData['crest'] ?? ''
      ..country = teamData['country'] ?? teamData['area']?['name'] ?? ''
      ..league = teamData['league'] ?? json['runningCompetitions']?[0]?['name'] ?? ''
      ..founded = safeGetInt(teamData, ['founded'])
      ..stadium = venueData['name'] ?? teamData['venue'] ?? ''
      ..capacity = safeGetInt(venueData, ['capacity'])
      ..coach = teamData['coach']?['name'] ?? '';

    team.stats.fromJson(json['stats'] ?? {});
    
    // The players will be populated from the backlink
    return team;
  }
}

@embedded
class TeamStats {
  int? matchesPlayed;
  int? wins;
  int? draws;
  int? losses;
  int? goalsFor;
  int? goalsAgainst;
  int? points;

  TeamStats();
  
  void fromJson(Map<String, dynamic> json) {
    matchesPlayed = safeGetInt(json, ['fixtures', 'played', 'total']);
    wins = safeGetInt(json, ['fixtures', 'wins', 'total']);
    draws = safeGetInt(json, ['fixtures', 'draws', 'total']);
    losses = safeGetInt(json, ['fixtures', 'loses', 'total']);
    goalsFor = safeGetInt(json, ['goals', 'for', 'total', 'total']);
    goalsAgainst = safeGetInt(json, ['goals', 'against', 'total', 'total']);
    points = 0; // Points are not available in the API
  }
}
