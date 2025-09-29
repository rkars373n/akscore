import 'dart:async';
import 'dart:math';
import '../models/match.dart';
import '../models/team.dart';

class RealtimeService {
  final _matchController = StreamController<Match>.broadcast();
  Stream<Match> get matchUpdates => _matchController.stream;

  RealtimeService() {
    // Simulate live match updates
    Timer.periodic(const Duration(seconds: 10), (timer) {
      _simulateMatchUpdate();
    });
  }

  void _simulateMatchUpdate() {
    // Create a fake match update
    final fakeMatch = _createFakeMatchUpdate();
    _matchController.add(fakeMatch);
  }

  Match _createFakeMatchUpdate() {
    // This is just a simplified example. 
    // In a real app, you'd get this data from a websocket or other realtime source.
    return Match(
      id: 1, // A consistent ID for the match being updated
      competition: 'Premier League',
      season: '2023/24',
      utcDate: DateTime.now(),
      status: 'IN_PLAY',
      matchday: 1,
      stage: 'REGULAR_SEASON',
      group: 'Group A',
      lastUpdated: DateTime.now(),
      homeTeam: Team(id: 1, name: 'Manchester United', shortName: 'Man United', tla: 'MUN', crest: 'https://crests.football-data.org/65.png', address: 'Sir Matt Busby Way, Old Trafford, Stretford, Manchester M16 0RA', website: 'www.manutd.com', founded: 1878, clubColors: 'Red, White, Black', venue: 'Old Trafford'),
      awayTeam: Team(id: 3, name: 'Arsenal FC', shortName: 'Arsenal', tla: 'ARS', crest: 'https://crests.football-data.org/57.png', address: '75 Drayton Park, London N5 1BU', website: 'www.arsenal.com', founded: 1886, clubColors: 'Red, White', venue: 'Emirates Stadium'),
      score: Score(
        winner: 'HOME_TEAM',
        duration: 'REGULAR',
        fullTime: FullTime(home: Random().nextInt(5), away: Random().nextInt(5)),
        halfTime: HalfTime(home: 0, away: 0),
      ),
      events: [],
    );
  }

  void dispose() {
    _matchController.close();
  }
}
