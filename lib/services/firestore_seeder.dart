import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirestoreSeeder {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final Logger _logger = Logger();

  /// Seed the database with sample data
  static Future<void> seedDatabase() async {
    try {
      _logger.i('🌱 Starting Firestore database seeding...');

      // Seed teams first
      await _seedTeams();

      // Seed players
      await _seedPlayers();

      // Seed matches
      await _seedMatches();

      _logger.i('✅ Database seeding completed successfully!');
    } catch (e) {
      _logger.e('❌ Error seeding database: $e');
      rethrow;
    }
  }

  /// Seed teams data
  static Future<void> _seedTeams() async {
    _logger.i('📊 Seeding teams...');

    final teams = [
      {
        'name': 'Manchester United',
        'shortName': 'Man Utd',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Manchester-United-Logo.png',
        'country': 'England',
        'league': 'Premier League',
        'founded': 1878,
        'stadium': 'Old Trafford',
        'website': 'https://www.manutd.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Manchester City',
        'shortName': 'Man City',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Manchester-City-Logo.png',
        'country': 'England',
        'league': 'Premier League',
        'founded': 1880,
        'stadium': 'Etihad Stadium',
        'website': 'https://www.mancity.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Liverpool',
        'shortName': 'Liverpool',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Liverpool-Logo.png',
        'country': 'England',
        'league': 'Premier League',
        'founded': 1892,
        'stadium': 'Anfield',
        'website': 'https://www.liverpoolfc.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Arsenal',
        'shortName': 'Arsenal',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Arsenal-Logo.png',
        'country': 'England',
        'league': 'Premier League',
        'founded': 1886,
        'stadium': 'Emirates Stadium',
        'website': 'https://www.arsenal.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Chelsea',
        'shortName': 'Chelsea',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Chelsea-Logo.png',
        'country': 'England',
        'league': 'Premier League',
        'founded': 1905,
        'stadium': 'Stamford Bridge',
        'website': 'https://www.chelseafc.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Real Madrid',
        'shortName': 'Real Madrid',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Real-Madrid-Logo.png',
        'country': 'Spain',
        'league': 'La Liga',
        'founded': 1902,
        'stadium': 'Santiago Bernabéu',
        'website': 'https://www.realmadrid.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Barcelona',
        'shortName': 'Barcelona',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Barcelona-Logo.png',
        'country': 'Spain',
        'league': 'La Liga',
        'founded': 1899,
        'stadium': 'Camp Nou',
        'website': 'https://www.fcbarcelona.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Bayern Munich',
        'shortName': 'Bayern',
        'logo':
            'https://logos-world.net/wp-content/uploads/2020/06/Bayern-Munich-Logo.png',
        'country': 'Germany',
        'league': 'Bundesliga',
        'founded': 1900,
        'stadium': 'Allianz Arena',
        'website': 'https://www.fcbayern.com',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    final batch = _firestore.batch();

    for (final teamData in teams) {
      final docRef = _firestore.collection('teams').doc();
      batch.set(docRef, teamData);
    }

    await batch.commit();
    _logger.i('✅ Teams seeded successfully');
  }

  /// Seed players data
  static Future<void> _seedPlayers() async {
    _logger.i('👥 Seeding players...');

    // Get team IDs first
    final teamsSnapshot = await _firestore.collection('teams').get();
    final teamIds = teamsSnapshot.docs.map((doc) => doc.id).toList();

    if (teamIds.isEmpty) {
      _logger.w('⚠️ No teams found. Please seed teams first.');
      return;
    }

    final players = [
      // Manchester United players
      {
        'name': 'Marcus Rashford',
        'teamId': teamIds[0], // Man Utd
        'position': 'Forward',
        'jerseyNumber': 10,
        'age': 26,
        'nationality': 'England',
        'height': 180,
        'weight': 70,
        'photo': 'https://example.com/rashford.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Bruno Fernandes',
        'teamId': teamIds[0], // Man Utd
        'position': 'Midfielder',
        'jerseyNumber': 18,
        'age': 29,
        'nationality': 'Portugal',
        'height': 179,
        'weight': 69,
        'photo': 'https://example.com/fernandes.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      // Manchester City players
      {
        'name': 'Erling Haaland',
        'teamId': teamIds[1], // Man City
        'position': 'Forward',
        'jerseyNumber': 9,
        'age': 23,
        'nationality': 'Norway',
        'height': 194,
        'weight': 88,
        'photo': 'https://example.com/haaland.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Kevin De Bruyne',
        'teamId': teamIds[1], // Man City
        'position': 'Midfielder',
        'jerseyNumber': 17,
        'age': 32,
        'nationality': 'Belgium',
        'height': 181,
        'weight': 70,
        'photo': 'https://example.com/debruyne.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      // Liverpool players
      {
        'name': 'Mohamed Salah',
        'teamId': teamIds[2], // Liverpool
        'position': 'Forward',
        'jerseyNumber': 11,
        'age': 31,
        'nationality': 'Egypt',
        'height': 175,
        'weight': 71,
        'photo': 'https://example.com/salah.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'name': 'Virgil van Dijk',
        'teamId': teamIds[2], // Liverpool
        'position': 'Defender',
        'jerseyNumber': 4,
        'age': 32,
        'nationality': 'Netherlands',
        'height': 193,
        'weight': 92,
        'photo': 'https://example.com/vandijk.jpg',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    final batch = _firestore.batch();

    for (final playerData in players) {
      final docRef = _firestore.collection('players').doc();
      batch.set(docRef, playerData);
    }

    await batch.commit();
    _logger.i('✅ Players seeded successfully');
  }

  /// Seed matches data
  static Future<void> _seedMatches() async {
    _logger.i('⚽ Seeding matches...');

    // Get team IDs
    final teamsSnapshot = await _firestore.collection('teams').get();
    final teamIds = teamsSnapshot.docs.map((doc) => doc.id).toList();

    if (teamIds.length < 2) {
      _logger.w('⚠️ Not enough teams found. Please seed teams first.');
      return;
    }

    final now = DateTime.now();
    final matches = [
      {
        'homeTeamId': teamIds[0], // Man Utd
        'awayTeamId': teamIds[1], // Man City
        'homeScore': 2,
        'awayScore': 1,
        'status': 'finished',
        'date': Timestamp.fromDate(now.subtract(const Duration(days: 1))),
        'league': 'Premier League',
        'venue': 'Old Trafford',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'homeTeamId': teamIds[2], // Liverpool
        'awayTeamId': teamIds[3], // Arsenal
        'homeScore': 3,
        'awayScore': 0,
        'status': 'finished',
        'date': Timestamp.fromDate(now.subtract(const Duration(days: 2))),
        'league': 'Premier League',
        'venue': 'Anfield',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'homeTeamId': teamIds[4], // Chelsea
        'awayTeamId': teamIds[0], // Man Utd
        'homeScore': null,
        'awayScore': null,
        'status': 'live',
        'date': Timestamp.fromDate(now),
        'league': 'Premier League',
        'venue': 'Stamford Bridge',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'homeTeamId': teamIds[5], // Real Madrid
        'awayTeamId': teamIds[6], // Barcelona
        'homeScore': null,
        'awayScore': null,
        'status': 'scheduled',
        'date': Timestamp.fromDate(now.add(const Duration(days: 1))),
        'league': 'La Liga',
        'venue': 'Santiago Bernabéu',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      {
        'homeTeamId': teamIds[7], // Bayern Munich
        'awayTeamId': teamIds[5], // Real Madrid
        'homeScore': null,
        'awayScore': null,
        'status': 'scheduled',
        'date': Timestamp.fromDate(now.add(const Duration(days: 3))),
        'league': 'Champions League',
        'venue': 'Allianz Arena',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    ];

    final batch = _firestore.batch();

    for (final matchData in matches) {
      final docRef = _firestore.collection('matches').doc();
      batch.set(docRef, matchData);
    }

    await batch.commit();
    _logger.i('✅ Matches seeded successfully');
  }

  /// Clear all data (for testing)
  static Future<void> clearAllData() async {
    _logger.i('🗑️ Clearing all Firestore data...');

    final collections = ['matches', 'teams', 'players', 'favorites', 'users'];

    for (final collection in collections) {
      final snapshot = await _firestore.collection(collection).get();
      final batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      if (snapshot.docs.isNotEmpty) {
        await batch.commit();
      }
    }

    _logger.i('✅ All data cleared');
  }

  /// Get database statistics
  static Future<Map<String, int>> getDatabaseStats() async {
    final stats = <String, int>{};

    final collections = ['matches', 'teams', 'players', 'favorites', 'users'];

    for (final collection in collections) {
      final snapshot = await _firestore.collection(collection).get();
      stats[collection] = snapshot.docs.length;
    }

    return stats;
  }
}
