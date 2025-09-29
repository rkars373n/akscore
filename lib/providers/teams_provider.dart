import 'package:flutter/material.dart';
import '../models/team.dart';
import '../services/real_api_service.dart';
import '../config/api_config.dart';

class TeamsProvider with ChangeNotifier {
  final RealApiService _apiService = RealApiService(
    footballDataApiKey: ApiConfig.footballDataApiKey,
    rapidApiKey: ApiConfig.rapidApiKey,
  );

  List<Team> _teams = [];
  final List<Team> _favoriteTeams = [];
  bool _isLoading = false;
  String? _error;

  List<Team> get teams => _teams;
  List<Team> get favoriteTeams => _favoriteTeams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTeams() async {
    _setLoading(true);
    try {
      _teams = await _apiService.getTeams();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  Future<void> loadTeamDetails(int teamId) async {
    _setLoading(true);
    try {
      final team = await _apiService.getTeamDetails(teamId);
      // Update the team in the list if it exists
      final index = _teams.indexWhere((t) => t.id == teamId);
      if (index != -1) {
        _teams[index] = team;
      } else {
        _teams.add(team);
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void addToFavorites(Team team) {
    if (!_favoriteTeams.any((t) => t.id == team.id)) {
      _favoriteTeams.add(team);
      notifyListeners();
    }
  }

  void removeFromFavorites(Team team) {
    _favoriteTeams.removeWhere((t) => t.id == team.id);
    notifyListeners();
  }

  bool isFavorite(Team team) {
    return _favoriteTeams.any((t) => t.id == team.id);
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
