import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../models/favorite.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collections
  static const String _matchesCollection = 'matches';
  static const String _teamsCollection = 'teams';
  static const String _playersCollection = 'players';
  static const String _favoritesCollection = 'favorites';
  static const String _usersCollection = 'users';

  // ==================== MATCHES ====================

  /// Get all matches
  static Stream<List<Match>> getMatches() {
    return _firestore
        .collection(_matchesCollection)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Match.fromJson(doc.data());
          }).toList();
        });
  }

  /// Get live matches
  static Stream<List<Match>> getLiveMatches() {
    return _firestore
        .collection(_matchesCollection)
        .where('status', isEqualTo: 'live')
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Match.fromJson(doc.data());
          }).toList();
        });
  }

  /// Get matches by date
  static Stream<List<Match>> getMatchesByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _firestore
        .collection(_matchesCollection)
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Match.fromJson(doc.data());
          }).toList();
        });
  }

  /// Add a new match
  static Future<void> addMatch(Match match) async {
    await _firestore.collection(_matchesCollection).add(match.toJson());
  }

  /// Update match
  static Future<void> updateMatch(
    String matchId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore
        .collection(_matchesCollection)
        .doc(matchId)
        .update(updates);
  }

  /// Delete match
  static Future<void> deleteMatch(String matchId) async {
    await _firestore.collection(_matchesCollection).doc(matchId).delete();
  }

  // ==================== TEAMS ====================

  /// Get all teams
  static Stream<List<Team>> getTeams() {
    return _firestore
        .collection(_teamsCollection)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Team.fromJson(doc.data());
          }).toList();
        });
  }

  /// Get team by ID
  static Future<Team?> getTeamById(String teamId) async {
    final doc = await _firestore.collection(_teamsCollection).doc(teamId).get();
    if (doc.exists) {
      return Team.fromJson(doc.data()!);
    }
    return null;
  }

  /// Add a new team
  static Future<void> addTeam(Team team) async {
    await _firestore.collection(_teamsCollection).add(team.toJson());
  }

  /// Update team
  static Future<void> updateTeam(
    String teamId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore.collection(_teamsCollection).doc(teamId).update(updates);
  }

  // ==================== PLAYERS ====================

  /// Get players by team
  static Stream<List<Player>> getPlayersByTeam(String teamId) {
    return _firestore
        .collection(_playersCollection)
        .where('teamId', isEqualTo: teamId)
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Player.fromJson(doc.data());
          }).toList();
        });
  }

  /// Get player by ID
  static Future<Player?> getPlayerById(String playerId) async {
    final doc = await _firestore
        .collection(_playersCollection)
        .doc(playerId)
        .get();
    if (doc.exists) {
      return Player.fromJson(doc.data()!);
    }
    return null;
  }

  /// Add a new player
  static Future<void> addPlayer(Player player) async {
    await _firestore.collection(_playersCollection).add(player.toJson());
  }

  /// Update player
  static Future<void> updatePlayer(
    String playerId,
    Map<String, dynamic> updates,
  ) async {
    await _firestore
        .collection(_playersCollection)
        .doc(playerId)
        .update(updates);
  }

  // ==================== FAVORITES ====================

  /// Get user's favorites
  static Stream<List<Favorite>> getUserFavorites(String userId) {
    return _firestore
        .collection(_favoritesCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Favorite.fromJson(doc.data());
          }).toList();
        });
  }

  /// Add favorite
  static Future<void> addFavorite(Favorite favorite) async {
    await _firestore.collection(_favoritesCollection).add(favorite.toJson());
  }

  /// Remove favorite
  static Future<void> removeFavorite(String favoriteId) async {
    await _firestore.collection(_favoritesCollection).doc(favoriteId).delete();
  }

  /// Check if item is favorited
  static Future<bool> isFavorited(
    String userId,
    String itemId,
    String itemType,
  ) async {
    final query = await _firestore
        .collection(_favoritesCollection)
        .where('userId', isEqualTo: userId)
        .where('itemId', isEqualTo: itemId)
        .where('itemType', isEqualTo: itemType)
        .get();

    return query.docs.isNotEmpty;
  }

  // ==================== USER DATA ====================

  /// Get user profile
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final doc = await _firestore.collection(_usersCollection).doc(userId).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  /// Update user profile
  static Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(_usersCollection)
        .doc(userId)
        .set(data, SetOptions(merge: true));
  }

  /// Create user profile
  static Future<void> createUserProfile(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    await _firestore.collection(_usersCollection).doc(userId).set(userData);
  }

  // ==================== SEARCH ====================

  /// Search teams
  static Stream<List<Team>> searchTeams(String query) {
    return _firestore
        .collection(_teamsCollection)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: '${query}z')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Team.fromJson(doc.data());
          }).toList();
        });
  }

  /// Search players
  static Stream<List<Player>> searchPlayers(String query) {
    return _firestore
        .collection(_playersCollection)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: '${query}z')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Player.fromJson(doc.data());
          }).toList();
        });
  }

  // ==================== BATCH OPERATIONS ====================

  /// Batch write operations
  static Future<void> batchWrite(List<Map<String, dynamic>> operations) async {
    final batch = _firestore.batch();

    for (final operation in operations) {
      final String type = operation['type'];
      final String collection = operation['collection'];
      final String? docId = operation['docId'];
      final Map<String, dynamic>? data = operation['data'];

      switch (type) {
        case 'set':
          if (docId != null && data != null) {
            batch.set(_firestore.collection(collection).doc(docId), data);
          }
          break;
        case 'update':
          if (docId != null && data != null) {
            batch.update(_firestore.collection(collection).doc(docId), data);
          }
          break;
        case 'delete':
          if (docId != null) {
            batch.delete(_firestore.collection(collection).doc(docId));
          }
          break;
      }
    }

    await batch.commit();
  }

  // ==================== REAL-TIME LISTENERS ====================

  /// Listen to match updates
  static Stream<DocumentSnapshot> listenToMatch(String matchId) {
    return _firestore.collection(_matchesCollection).doc(matchId).snapshots();
  }

  /// Listen to team updates
  static Stream<DocumentSnapshot> listenToTeam(String teamId) {
    return _firestore.collection(_teamsCollection).doc(teamId).snapshots();
  }

  /// Listen to player updates
  static Stream<DocumentSnapshot> listenToPlayer(String playerId) {
    return _firestore.collection(_playersCollection).doc(playerId).snapshots();
  }

  // ==================== UTILITY METHODS ====================

  /// Get server timestamp
  static FieldValue get serverTimestamp => FieldValue.serverTimestamp();

  /// Get current user ID
  static String? get currentUserId => _auth.currentUser?.uid;

  /// Check if user is authenticated
  static bool get isAuthenticated => _auth.currentUser != null;

  /// Get current user
  static User? get currentUser => _auth.currentUser;
}
