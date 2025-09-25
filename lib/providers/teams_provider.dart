import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../models/team.dart';
import '../services/real_api_service.dart';
import '../services/favorites_service.dart';

class TeamsProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService();
  final FavoritesService _favoritesService = FavoritesService();
  final _logger = Logger('TeamsProvider');
  
  List<Team> _favoriteTeams = [];
  bool _isLoading = false;
  String? _error;

  List<Team> get favoriteTeams => _favoriteTeams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFavoriteTeams() async {
    _setLoading(true);
    try {
      final favoriteTeamIds = await _favoritesService.getFavoriteIds('team');
      final favoriteTeams = <Team>[];
      for (final teamId in favoriteTeamIds) {
        try {
          final team = await _apiService.getTeamDetails(teamId);
          favoriteTeams.add(team);
        } catch (e, s) {
          _logger.warning('Error fetching team details for teamId: $teamId', e, s);
        }
      }
      _favoriteTeams = favoriteTeams;
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch favorite teams', e, s);
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> addToFavorites(String teamId) async {
    await _favoritesService.addFavorite(teamId, 'team');
    await fetchFavoriteTeams();
    notifyListeners();
  }

  Future<void> removeFromFavorites(String teamId) async {
    await _favoritesService.removeFavorite(teamId, 'team');
    await fetchFavoriteTeams();
    notifyListeners();
  }
  
  Future<bool> isFavorite(String teamId) async {
    return await _favoritesService.isFavorite(teamId, 'team');
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
