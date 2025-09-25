import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../models/player.dart';
import '../services/real_api_service.dart';
import '../services/favorites_service.dart';

class PlayersProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService();
  final FavoritesService _favoritesService = FavoritesService();
  final _logger = Logger('PlayersProvider');
  
  List<Player> _favoritePlayers = [];
  bool _isLoading = false;
  String? _error;

  List<Player> get favoritePlayers => _favoritePlayers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchFavoritePlayers() async {
    _setLoading(true);
    try {
      final favoritePlayerIds = await _favoritesService.getFavoriteIds('player');
      final favoritePlayers = <Player>[];
      for (final playerId in favoritePlayerIds) {
        try {
          final player = await _apiService.getPlayerDetails(playerId);
          favoritePlayers.add(player);
        } catch (e, s) {
          _logger.warning('Error fetching player details for playerId: $playerId', e, s);
        }
      }
      _favoritePlayers = favoritePlayers;
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch favorite players', e, s);
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> addToFavorites(String playerId) async {
    try {
      await _favoritesService.addFavorite(playerId, 'player');
      final player = await _apiService.getPlayerDetails(playerId);
      _favoritePlayers.add(player);
      notifyListeners();
    } catch (e, s) {
      _logger.severe('Failed to add player to favorites', e, s);
    }
  }

  Future<void> removeFromFavorites(String playerId) async {
    await _favoritesService.removeFavorite(playerId, 'player');
    _favoritePlayers.removeWhere((player) => player.id == playerId);
    notifyListeners();
  }
  
  Future<bool> isFavorite(String playerId) async {
    return await _favoritesService.isFavorite(playerId, 'player');
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
