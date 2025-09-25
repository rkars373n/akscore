import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';
import 'api_keys.dart';

class RealApiService {
  static const String _footballApiUrl = 'https://api.football-data.org/v4';
  static const String _rapidApiUrl = 'https://api-football-v1.p.rapidapi.com/v3';
  final _logger = Logger('RealApiService');
  
  final Map<String, String> _headers = {
    'X-Auth-Token': footballApiKey,
    'Content-Type': 'application/json',
  };

  final Map<String, String> _rapidHeaders = {
    'X-RapidAPI-Key': rapidApiKey,
    'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com',
  };

  Future<dynamic> _fetchApiData(String url, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(url), headers: headers ?? _headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from $url: ${response.statusCode}');
    }
  }

  Future<List<Match>> _fetchMatches(String url) async {
    final data = await _fetchApiData(url);
    return _parseMatchesFromApi(data);
  }

  Future<List<Match>> getLiveMatches() async {
    return _fetchMatches('$_footballApiUrl/matches?status=LIVE');
  }

  Future<List<Match>> getTodayMatches() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return _fetchMatches('$_footballApiUrl/matches?date=$today');
  }

  Future<Match> getMatchDetails(String matchId) async {
    final matchData = await _fetchApiData('$_footballApiUrl/matches/$matchId');
    
    dynamic statsData;
    try {
      final statsResponse = await _fetchApiData(
        '$_rapidApiUrl/fixtures/statistics?fixture=$matchId',
        headers: _rapidHeaders,
      );
      statsData = statsResponse['response'] as List<dynamic>?;
    } catch (e, s) {
      _logger.warning('Error fetching match stats for matchId: $matchId', e, s);
    }

    return _parseMatchFromApi(matchData, statsData);
  }

  Future<Team> getTeamDetails(String teamId) async {
    final teamData = await _fetchApiData('$_footballApiUrl/teams/$teamId');

    dynamic statsData;
    try {
      final statsResponse = await _fetchApiData(
        '$_rapidApiUrl/teams/statistics?team=$teamId&league=39&season=2023',
        headers: _rapidHeaders,
      );
      statsData = statsResponse['response'];
    } catch (e, s) {
      _logger.warning('Error fetching team stats for teamId: $teamId', e, s);
    }

    return _parseTeamFromApi(teamData, statsData);
  }

  Future<Player> getPlayerDetails(String playerId) async {
    final data = await _fetchApiData(
      '$_rapidApiUrl/players?id=$playerId&season=2023',
      headers: _rapidHeaders,
    );
    return Player.fromJson(data['response'][0]);
  }

  List<Match> _parseMatchesFromApi(Map<String, dynamic> data) {
    final List<dynamic> matches = data['matches'] ?? [];
    return matches.map((match) => Match.fromJson(match)).toList();
  }

  Map<String, int?> _extractTeamStats(List<dynamic>? statistics) {
    if (statistics == null) {
      return {};
    }

    dynamic getStat(String type) {
      final stat = statistics.firstWhere((s) => s['type'] == type, orElse: () => null);
      return stat?['value'];
    }

    int? parseStat(dynamic value) {
      if (value is int) {
        return value;
      }
      if (value is String) {
        return int.tryParse(value.replaceAll('%', ''));
      }
      return null;
    }

    return {
      'shots': parseStat(getStat('Total Shots')),
      'shotsOnTarget': parseStat(getStat('Shots on Goal')),
      'possession': parseStat(getStat('Ball Possession')),
      'passes': parseStat(getStat('Total passes')),
      'fouls': parseStat(getStat('Fouls')),
      'yellowCards': parseStat(getStat('Yellow Cards')),
      'redCards': parseStat(getStat('Red Cards')),
    };
  }

  Match _parseMatchFromApi(Map<String, dynamic> matchData, List<dynamic>? statsData) {
    final homeTeamId = matchData['homeTeam']?['id']?.toString();
    final awayTeamId = matchData['awayTeam']?['id']?.toString();

    Map<String, dynamic>? homeStatsData;
    Map<String, dynamic>? awayStatsData;

    if (statsData != null && statsData.isNotEmpty) {
      homeStatsData = statsData.firstWhere(
        (team) => team['team']?['id']?.toString() == homeTeamId,
        orElse: () => null,
      );
      awayStatsData = statsData.firstWhere(
        (team) => team['team']?['id']?.toString() == awayTeamId,
        orElse: () => null,
      );
    }

    final homeStatisticsList = homeStatsData?['statistics'] as List<dynamic>?;
    final awayStatisticsList = awayStatsData?['statistics'] as List<dynamic>?;

    final combinedData = {
      ...matchData,
      'statistics': {
        'home': _extractTeamStats(homeStatisticsList),
        'away': _extractTeamStats(awayStatisticsList),
      },
    };

    return Match.fromJson(combinedData);
  }

  Team _parseTeamFromApi(Map<String, dynamic> teamData, Map<String, dynamic>? statsData) {
    final combinedData = {
      ...teamData,
      'stats': statsData ?? {},
    };
    return Team.fromJson(combinedData);
  }
}
