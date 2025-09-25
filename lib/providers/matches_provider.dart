import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../models/match.dart';
import '../services/real_api_service.dart';
import '../services/favorites_service.dart';

class MatchesProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService();
  final FavoritesService _favoritesService = FavoritesService();
  final _logger = Logger('MatchesProvider');

  List<Match> _liveMatches = [];
  List<Match> _todayMatches = [];
  List<Match> _favoriteMatches = [];
  bool _isLoading = false;
  String? _error;

  List<Match> get liveMatches => _liveMatches;
  List<Match> get todayMatches => _todayMatches;
  List<Match> get favoriteMatches => _favoriteMatches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLiveMatches() async {
    _setLoading(true);
    try {
      _liveMatches = await _apiService.getLiveMatches();
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch live matches', e, s);
      _error = e.toString();
      _liveMatches = [];
    }
    _setLoading(false);
  }

  Future<void> fetchTodayMatches() async {
    _setLoading(true);
    try {
      _todayMatches = await _apiService.getTodayMatches();
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch today matches', e, s);
      _error = e.toString();
      _todayMatches = [];
    }
    _setLoading(false);
  }

  Future<void> fetchFavoriteMatches() async {
    _setLoading(true);
    try {
      final favoriteMatchIds = await _favoritesService.getFavoriteIds('match');
      final favoriteMatches = <Match>[];
      for (final matchId in favoriteMatchIds) {
        try {
          final match = await _apiService.getMatchDetails(matchId);
          favoriteMatches.add(match);
        } catch (e, s) {
          _logger.warning('Error fetching match details for matchId: $matchId', e, s);
        }
      }
      _favoriteMatches = favoriteMatches;
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch favorite matches', e, s);
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> addToFavorites(String matchId) async {
    await _favoritesService.addFavorite(matchId, 'match');
    await fetchFavoriteMatches();
    notifyListeners();
  }

  Future<void> removeFromFavorites(String matchId) async {
    await _favoritesService.removeFavorite(matchId, 'match');
    await fetchFavoriteMatches();
    notifyListeners();
  }

  Future<bool> isFavorite(String matchId) async {
    return await _favoritesService.isFavorite(matchId, 'match');
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
