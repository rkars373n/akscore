import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../models/favorite.dart';
import '../services/firestore_service.dart';

class FirestoreProvider extends ChangeNotifier {
  // State variables
  List<Match> _matches = [];
  List<Team> _teams = [];
  List<Player> _players = [];
  List<Favorite> _favorites = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Match> get matches => _matches;
  List<Team> get teams => _teams;
  List<Player> get players => _players;
  List<Favorite> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ==================== MATCHES ====================

  /// Load all matches
  Future<void> loadMatches() async {
    _setLoading(true);
    try {
      FirestoreService.getMatches().listen((matches) {
        _matches = matches;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load matches: $e');
    }
  }

  /// Load live matches
  Future<void> loadLiveMatches() async {
    _setLoading(true);
    try {
      FirestoreService.getLiveMatches().listen((matches) {
        _matches = matches;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load live matches: $e');
    }
  }

  /// Load matches by date
  Future<void> loadMatchesByDate(DateTime date) async {
    _setLoading(true);
    try {
      FirestoreService.getMatchesByDate(date).listen((matches) {
        _matches = matches;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load matches for date: $e');
    }
  }

  /// Add match
  Future<void> addMatch(Match match) async {
    try {
      await FirestoreService.addMatch(match);
    } catch (e) {
      _setError('Failed to add match: $e');
    }
  }

  /// Update match
  Future<void> updateMatch(String matchId, Map<String, dynamic> updates) async {
    try {
      await FirestoreService.updateMatch(matchId, updates);
    } catch (e) {
      _setError('Failed to update match: $e');
    }
  }

  /// Delete match
  Future<void> deleteMatch(String matchId) async {
    try {
      await FirestoreService.deleteMatch(matchId);
    } catch (e) {
      _setError('Failed to delete match: $e');
    }
  }

  // ==================== TEAMS ====================

  /// Load all teams
  Future<void> loadTeams() async {
    _setLoading(true);
    try {
      FirestoreService.getTeams().listen((teams) {
        _teams = teams;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load teams: $e');
    }
  }

  /// Get team by ID
  Future<Team?> getTeamById(String teamId) async {
    try {
      return await FirestoreService.getTeamById(teamId);
    } catch (e) {
      _setError('Failed to get team: $e');
      return null;
    }
  }

  /// Add team
  Future<void> addTeam(Team team) async {
    try {
      await FirestoreService.addTeam(team);
    } catch (e) {
      _setError('Failed to add team: $e');
    }
  }

  /// Update team
  Future<void> updateTeam(String teamId, Map<String, dynamic> updates) async {
    try {
      await FirestoreService.updateTeam(teamId, updates);
    } catch (e) {
      _setError('Failed to update team: $e');
    }
  }

  /// Search teams
  Future<void> searchTeams(String query) async {
    _setLoading(true);
    try {
      FirestoreService.searchTeams(query).listen((teams) {
        _teams = teams;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to search teams: $e');
    }
  }

  // ==================== PLAYERS ====================

  /// Load players by team
  Future<void> loadPlayersByTeam(String teamId) async {
    _setLoading(true);
    try {
      FirestoreService.getPlayersByTeam(teamId).listen((players) {
        _players = players;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load players: $e');
    }
  }

  /// Get player by ID
  Future<Player?> getPlayerById(String playerId) async {
    try {
      return await FirestoreService.getPlayerById(playerId);
    } catch (e) {
      _setError('Failed to get player: $e');
      return null;
    }
  }

  /// Add player
  Future<void> addPlayer(Player player) async {
    try {
      await FirestoreService.addPlayer(player);
    } catch (e) {
      _setError('Failed to add player: $e');
    }
  }

  /// Update player
  Future<void> updatePlayer(
    String playerId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await FirestoreService.updatePlayer(playerId, updates);
    } catch (e) {
      _setError('Failed to update player: $e');
    }
  }

  /// Search players
  Future<void> searchPlayers(String query) async {
    _setLoading(true);
    try {
      FirestoreService.searchPlayers(query).listen((players) {
        _players = players;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to search players: $e');
    }
  }

  // ==================== FAVORITES ====================

  /// Load user favorites
  Future<void> loadUserFavorites(String userId) async {
    _setLoading(true);
    try {
      FirestoreService.getUserFavorites(userId).listen((favorites) {
        _favorites = favorites;
        _setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load favorites: $e');
    }
  }

  /// Add favorite
  Future<void> addFavorite(Favorite favorite) async {
    try {
      await FirestoreService.addFavorite(favorite);
    } catch (e) {
      _setError('Failed to add favorite: $e');
    }
  }

  /// Remove favorite
  Future<void> removeFavorite(String favoriteId) async {
    try {
      await FirestoreService.removeFavorite(favoriteId);
    } catch (e) {
      _setError('Failed to remove favorite: $e');
    }
  }

  /// Check if item is favorited
  Future<bool> isFavorited(
    String userId,
    String itemId,
    String itemType,
  ) async {
    try {
      return await FirestoreService.isFavorited(userId, itemId, itemType);
    } catch (e) {
      _setError('Failed to check favorite status: $e');
      return false;
    }
  }

  // ==================== USER PROFILE ====================

  /// Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      return await FirestoreService.getUserProfile(userId);
    } catch (e) {
      _setError('Failed to get user profile: $e');
      return null;
    }
  }

  /// Update user profile
  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await FirestoreService.updateUserProfile(userId, data);
    } catch (e) {
      _setError('Failed to update user profile: $e');
    }
  }

  /// Create user profile
  Future<void> createUserProfile(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    try {
      await FirestoreService.createUserProfile(userId, userData);
    } catch (e) {
      _setError('Failed to create user profile: $e');
    }
  }

  // ==================== REAL-TIME LISTENERS ====================

  /// Listen to match updates
  Stream<DocumentSnapshot> listenToMatch(String matchId) {
    return FirestoreService.listenToMatch(matchId);
  }

  /// Listen to team updates
  Stream<DocumentSnapshot> listenToTeam(String teamId) {
    return FirestoreService.listenToTeam(teamId);
  }

  /// Listen to player updates
  Stream<DocumentSnapshot> listenToPlayer(String playerId) {
    return FirestoreService.listenToPlayer(playerId);
  }

  // ==================== UTILITY METHODS ====================

  /// Clear all data
  void clearData() {
    _matches.clear();
    _teams.clear();
    _players.clear();
    _favorites.clear();
    _error = null;
    notifyListeners();
  }

  /// Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([loadMatches(), loadTeams()]);
  }

  // ==================== PRIVATE METHODS ====================

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
