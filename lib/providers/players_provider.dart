import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../models/player.dart';
import '../services/favorites_service.dart';
import '../services/isar_service.dart';
import '../services/real_api_service.dart';

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
      await _savePlayersToCache(_favoritePlayers);
      _error = null;
    } catch (e, s) {
      _logger.severe('Failed to fetch favorite players, loading from cache', e, s);
      _error = e.toString();
      await _loadPlayersFromCache();
    }
    _setLoading(false);
  }

  Future<void> _savePlayersToCache(List<Player> players) async {
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      await isar.players.putAll(players);
    });
    _logger.info('Saved ${players.length} players to cache.');
  }

  Future<void> _loadPlayersFromCache() async {
    final isar = IsarService.isar;
    final favoritePlayerIds = await _favoritesService.getFavoriteIds('player');
    final players = await isar.players.getAll(favoritePlayerIds.map(int.parse).toList());
    _favoritePlayers = players.where((p) => p != null).cast<Player>().toList();
    _logger.info('Loaded ${_favoritePlayers.length} players from cache.');
  }

  Future<void> addToFavorites(String playerId) async {
    try {
      await _favoritesService.addFavorite(playerId, 'player');
      final player = await _apiService.getPlayerDetails(playerId);
      _favoritePlayers.add(player);
      await _savePlayersToCache([player]);
      notifyListeners();
    } catch (e, s) {
      _logger.severe('Failed to add player to favorites', e, s);
    }
  }

  Future<void> removeFromFavorites(String playerId) async {
    await _favoritesService.removeFavorite(playerId, 'player');
    _favoritePlayers.removeWhere((player) => player.id == playerId);
    final isar = IsarService.isar;
    await isar.writeTxn(() async {
      await isar.players.delete(int.parse(playerId));
    });
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
