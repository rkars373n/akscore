import 'package:flutter/material.dart';
import '../models/player.dart';
import '../services/real_api_service.dart';
import '../config/api_config.dart';

class PlayersProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService(
    footballDataApiKey: ApiConfig.footballDataApiKey,
    rapidApiKey: ApiConfig.rapidApiKey,
  );

  List<Player> _players = [];
  final List<Player> _favoritePlayers = [];
  bool _isLoading = false;
  String? _error;

  List<Player> get players => _players;
  List<Player> get favoritePlayers => _favoritePlayers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPlayers() async {
    _setLoading(true);
    try {
      _players = await _apiService.getPlayers();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loadPlayerDetails(int playerId) async {
    _setLoading(true);
    try {
      final player = await _apiService.getPlayerDetails(playerId);
      // Update the player in the list if it exists
      final index = _players.indexWhere((p) => p.id == playerId);
      if (index != -1) {
        _players[index] = player;
      } else {
        _players.add(player);
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loadTeamPlayers(int teamId) async {
    _setLoading(true);
    try {
      _players = await _apiService.getTeamPlayers(teamId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void addToFavorites(Player player) {
    if (!_favoritePlayers.any((p) => p.id == player.id)) {
      _favoritePlayers.add(player);
      notifyListeners();
    }
  }

  void removeFromFavorites(Player player) {
    _favoritePlayers.removeWhere((p) => p.id == player.id);
    notifyListeners();
  }

  bool isFavorite(Player player) {
    return _favoritePlayers.any((p) => p.id == player.id);
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
