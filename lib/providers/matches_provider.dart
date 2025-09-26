
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

import '../models/match.dart';
import '../models/team.dart';
import '../services/favorites_service.dart';
import '../services/isar_service.dart';
import '../services/real_api_service.dart';

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
    await _fetchMatches(
      fetcher: () => _apiService.getLiveMatches(),
      cacheUpdater: (matches) => _liveMatches = matches,
      cacheQuery: (isar) => isar.matchs.filter().isLiveEqualTo(true).findAll(),
    );
  }

  Future<void> fetchTodayMatches() async {
    await _fetchMatches(
      fetcher: () => _apiService.getTodayMatches(),
      cacheUpdater: (matches) => _todayMatches = matches,
      cacheQuery: (isar) {
        final today = DateTime.now();
        final startOfDay = DateTime(today.year, today.month, today.day);
        final endOfDay = startOfDay.add(const Duration(days: 1));
        return isar.matchs
            .filter()
            .matchTimeBetween(startOfDay, endOfDay)
            .findAll();
      },
    );
  }

  Future<void> _fetchMatches({
    required Future<List<Match>> Function() fetcher,
    required void Function(List<Match>) cacheUpdater,
    required Future<List<Match>> Function(Isar) cacheQuery,
  }) async {
    _setLoading(true);
    try {
      final matches = await fetcher();
      cacheUpdater(matches);
      await _saveMatchesToCache(matches);
      _error = null;
    } catch (e, s) {
      _logger.warning('Failed to fetch matches online, loading from cache', e, s);
      _error = e.toString();
      await _loadMatchesFromCache(cacheUpdater, cacheQuery);
    }
    _setLoading(false);
  }

  Future<void> _saveMatchesToCache(List<Match> matches) async {
    final isar = IsarService.isar;
    final teams = <Team>[];

    for (final match in matches) {
      if (match.homeTeam.value != null) {
        teams.add(match.homeTeam.value!);
      }
      if (match.awayTeam.value != null) {
        teams.add(match.awayTeam.value!);
      }
    }

    await isar.writeTxn(() async {
      await isar.teams.putAll(teams);
      await isar.matchs.putAll(matches);
      for (final match in matches) {
        await match.homeTeam.save();
        await match.awayTeam.save();
      }
    });
    _logger.info('Saved ${matches.length} matches and ${teams.length} teams to cache.');
  }

  Future<void> _loadMatchesFromCache(
    void Function(List<Match>) cacheUpdater,
    Future<List<Match>> Function(Isar) cacheQuery,
  ) async {
    final isar = IsarService.isar;
    final matches = await cacheQuery(isar);
    for (final match in matches) {
      await match.homeTeam.load();
      await match.awayTeam.load();
    }
    cacheUpdater(matches);
    _logger.info('Loaded ${matches.length} matches from cache.');
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
      await _saveMatchesToCache(_favoriteMatches);
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
