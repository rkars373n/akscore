import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../config/api_config.dart';

class RealApiService {
  // API Keys from configuration
  static const String _footballDataApiKey = ApiConfig.footballDataApiKey;
  static const String _rapidApiKey = ApiConfig.rapidApiKey;
  
  static const String _footballDataBaseUrl = ApiConfig.footballDataBaseUrl;
  static const String _rapidApiBaseUrl = ApiConfig.rapidApiBaseUrl;

  Map<String, String> get _footballDataHeaders => {
    'X-Auth-Token': _footballDataApiKey,
    'Content-Type': 'application/json',
  };

  Map<String, String> get _rapidApiHeaders => {
    'X-RapidAPI-Key': _rapidApiKey,
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
  };

  Future<List<Match>> getLiveMatches() async {
    try {
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/matches?status=LIVE'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = (data['matches'] as List)
            .map((json) => Match.fromJson(json))
            .toList();
        return matches;
      } else {
        throw Exception('Failed to load live matches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching live matches: $e');
    }
  }

  Future<List<Match>> getTodayMatches() async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/matches?date=$today'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = (data['matches'] as List)
            .map((json) => Match.fromJson(json))
            .toList();
        return matches;
      } else {
        throw Exception('Failed to load today matches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching today matches: $e');
    }
  }

  Future<List<Match>> getMatchesForDateRange(DateTimeRange dateRange) async {
    try {
      final dateFrom = dateRange.start.toIso8601String().split('T')[0];
      final dateTo = dateRange.end.toIso8601String().split('T')[0];
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/matches?dateFrom=$dateFrom&dateTo=$dateTo'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = (data['matches'] as List)
            .map((json) => Match.fromJson(json))
            .toList();
        return matches;
      } else {
        throw Exception('Failed to load matches for date range: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching matches for date range: $e');
    }
  }

  Future<Match> getMatchDetails(int matchId) async {
    try {
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/matches/$matchId'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Match.fromJson(data);
      } else {
        throw Exception('Failed to load match details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching match details: $e');
    }
  }

  Future<List<Team>> getTeams() async {
    try {
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/teams'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final teams = (data['teams'] as List)
            .map((json) => Team.fromJson(json))
            .toList();
        return teams;
      } else {
        throw Exception('Failed to load teams: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching teams: $e');
    }
  }

  Future<Team> getTeamDetails(int teamId) async {
    try {
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/teams/$teamId'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Team.fromJson(data);
      } else {
        throw Exception('Failed to load team details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching team details: $e');
    }
  }

  Future<List<Player>> getPlayers() async {
    try {
      final response = await http.get(
        Uri.parse('$_rapidApiBaseUrl/players'),
        headers: _rapidApiHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final players = (data['response'] as List)
            .map((json) => Player.fromJson(json['player']))
            .toList();
        return players;
      } else {
        throw Exception('Failed to load players: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching players: $e');
    }
  }

  Future<Player> getPlayerDetails(int playerId) async {
    try {
      final response = await http.get(
        Uri.parse('$_rapidApiBaseUrl/players?id=$playerId'),
        headers: _rapidApiHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['response'].isNotEmpty) {
          return Player.fromJson(data['response'][0]['player']);
        } else {
          throw Exception('Player not found');
        }
      } else {
        throw Exception('Failed to load player details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching player details: $e');
    }
  }

  Future<List<Player>> getTeamPlayers(int teamId) async {
    try {
      final response = await http.get(
        Uri.parse('$_rapidApiBaseUrl/players/squads?team=$teamId'),
        headers: _rapidApiHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final players = (data['response'][0]['players'] as List)
            .map((json) => Player.fromJson(json))
            .toList();
        return players;
      } else {
        throw Exception('Failed to load team players: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching team players: $e');
    }
  }

  Future<List<Match>> getTeamMatches(int teamId) async {
    try {
      final response = await http.get(
        Uri.parse('$_footballDataBaseUrl/teams/$teamId/matches'),
        headers: _footballDataHeaders,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = (data['matches'] as List)
            .map((json) => Match.fromJson(json))
            .toList();
        return matches;
      } else {
        throw Exception('Failed to load team matches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching team matches: $e');
    }
  }
}
