import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';

class FakeApiService {
  Future<Map<String, dynamic>> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/data/db.json');
    return json.decode(jsonString);
  }

  Future<List<Match>> _getMatches(String key) async {
    final data = await _loadData();
    final List<dynamic> matchesJson = data[key];
    return matchesJson.map((json) => Match.fromJson(json)).toList();
  }

  Future<List<Match>> getLiveMatches() async {
    return _getMatches('live_matches');
  }

  Future<List<Match>> getTodayMatches() async {
    return _getMatches('today_matches');
  }

  Future<Match> getMatchDetails(String matchId) async {
    final data = await _loadData();
    final Map<String, dynamic> matchJson = data['match_details'][matchId];
    return Match.fromJson(matchJson);
  }

  Future<Team> getTeamDetails(String teamId) async {
    final data = await _loadData();
    final Map<String, dynamic> teamJson = data['team_details'][teamId];
    return Team.fromJson(teamJson);
  }

  Future<Player> getPlayerDetails(String playerId) async {
    final data = await _loadData();
    final Map<String, dynamic> playerJson = data['player_details'][playerId];
    return Player.fromJson(playerJson);
  }
}
