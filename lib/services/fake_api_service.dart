import 'dart:math';
import 'package:flutter/material.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';

class FakeApiService {
  static final Random _random = Random();

  Future<List<Match>> getLiveMatches() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return List.generate(5, (index) => _createFakeMatch(isLive: true));
  }

  Future<List<Match>> getTodayMatches() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return List.generate(10, (index) => _createFakeMatch(isLive: false));
  }

  Future<List<Match>> getMatchesForDateRange(DateTimeRange dateRange) async {
    await Future.delayed(const Duration(seconds: 1));
    final days = dateRange.duration.inDays;
    return List.generate(10 * days, (index) => _createFakeMatch(isLive: false));
  }

  Future<Match> getMatchDetails(int matchId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _createFakeMatch(isLive: true, id: matchId);
  }

  Future<List<Team>> getTeams() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return _fakeTeams;
  }

  Future<Team> getTeamDetails(int teamId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _fakeTeams.firstWhere((team) => team.id == teamId);
  }

  Future<List<Player>> getPlayers() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return _fakePlayers;
  }

  Future<Player> getPlayerDetails(int playerId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _fakePlayers.firstWhere((player) => player.id == playerId);
  }

  Future<List<Player>> getTeamPlayers(int teamId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return _fakePlayers.where((player) => player.id % 3 == teamId % 3).toList();
  }

  Future<List<Match>> getTeamMatches(int teamId) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return List.generate(5, (index) => _createFakeMatch(isLive: false));
  }

  Match _createFakeMatch({required bool isLive, int? id}) {
    final homeTeam = _fakeTeams[_random.nextInt(_fakeTeams.length)];
    final awayTeam = _fakeTeams[_random.nextInt(_fakeTeams.length)];
    
    return Match(
      id: id ?? _random.nextInt(1000),
      competition: 'Premier League',
      season: '2023/24',
      utcDate: DateTime.now().add(Duration(hours: _random.nextInt(24))),
      status: isLive ? 'IN_PLAY' : 'SCHEDULED',
      matchday: _random.nextInt(38) + 1,
      stage: 'REGULAR_SEASON',
      group: 'Group A',
      lastUpdated: DateTime.now(),
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      score: Score(
        winner: isLive ? (_random.nextBool() ? 'HOME_TEAM' : 'AWAY_TEAM') : 'UNKNOWN',
        duration: isLive ? 'REGULAR' : 'UNKNOWN',
        fullTime: FullTime(
          home: isLive ? _random.nextInt(5) : null,
          away: isLive ? _random.nextInt(5) : null,
        ),
        halfTime: HalfTime(
          home: isLive ? _random.nextInt(3) : null,
          away: isLive ? _random.nextInt(3) : null,
        ),
      ),
      events: isLive ? _createFakeEvents() : [],
    );
  }

  List<MatchEvent> _createFakeEvents() {
    return List.generate(3, (index) => MatchEvent(
      id: _random.nextInt(1000),
      type: 'GOAL',
      team: _random.nextBool() ? 'HOME_TEAM' : 'AWAY_TEAM',
      player: _fakePlayers[_random.nextInt(_fakePlayers.length)].name,
      minute: _random.nextInt(90) + 1,
      description: 'Goal scored',
      eventType: 'GOAL',
    ));
  }

  static final List<Team> _fakeTeams = [
    Team(
      id: 1,
      name: 'Manchester United',
      shortName: 'Man United',
      tla: 'MUN',
      crest: 'https://crests.football-data.org/65.png',
      address: 'Old Trafford, Manchester',
      website: 'https://www.manutd.com',
      founded: 1878,
      clubColors: 'Red / White / Black',
      venue: 'Old Trafford',
    ),
    Team(
      id: 2,
      name: 'Liverpool FC',
      shortName: 'Liverpool',
      tla: 'LIV',
      crest: 'https://crests.football-data.org/64.png',
      address: 'Anfield, Liverpool',
      website: 'https://www.liverpoolfc.com',
      founded: 1892,
      clubColors: 'Red',
      venue: 'Anfield',
    ),
    Team(
      id: 3,
      name: 'Arsenal FC',
      shortName: 'Arsenal',
      tla: 'ARS',
      crest: 'https://crests.football-data.org/57.png',
      address: 'Emirates Stadium, London',
      website: 'https://www.arsenal.com',
      founded: 1886,
      clubColors: 'Red / White',
      venue: 'Emirates Stadium',
    ),
    Team(
      id: 4,
      name: 'Chelsea FC',
      shortName: 'Chelsea',
      tla: 'CHE',
      crest: 'https://crests.football-data.org/61.png',
      address: 'Stamford Bridge, London',
      website: 'https://www.chelseafc.com',
      founded: 1905,
      clubColors: 'Blue / White',
      venue: 'Stamford Bridge',
    ),
    Team(
      id: 5,
      name: 'Manchester City',
      shortName: 'Man City',
      tla: 'MCI',
      crest: 'https://crests.football-data.org/65.png',
      address: 'Etihad Stadium, Manchester',
      website: 'https://www.mancity.com',
      founded: 1880,
      clubColors: 'Sky Blue / White',
      venue: 'Etihad Stadium',
    ),
  ];

  static final List<Player> _fakePlayers = [
    Player(
      id: 1,
      name: 'Cristiano Ronaldo',
      position: 'Forward',
      dateOfBirth: DateTime(1985, 2, 5),
      nationality: 'Portugal',
      shirtNumber: '7',
      role: 'Captain',
    ),
    Player(
      id: 2,
      name: 'Lionel Messi',
      position: 'Forward',
      dateOfBirth: DateTime(1987, 6, 24),
      nationality: 'Argentina',
      shirtNumber: '10',
      role: 'Captain',
    ),
    Player(
      id: 3,
      name: 'Neymar Jr',
      position: 'Forward',
      dateOfBirth: DateTime(1992, 2, 5),
      nationality: 'Brazil',
      shirtNumber: '10',
      role: 'Player',
    ),
    Player(
      id: 4,
      name: 'Kylian Mbappé',
      position: 'Forward',
      dateOfBirth: DateTime(1998, 12, 20),
      nationality: 'France',
      shirtNumber: '7',
      role: 'Player',
    ),
    Player(
      id: 5,
      name: 'Erling Haaland',
      position: 'Forward',
      dateOfBirth: DateTime(2000, 7, 21),
      nationality: 'Norway',
      shirtNumber: '9',
      role: 'Player',
    ),
  ];
}
