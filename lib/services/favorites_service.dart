import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/favorite.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  Future<List<Favorite>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];
    
    return favoritesJson
        .map((json) => Favorite.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> addFavorite(Favorite favorite) async {
    final favorites = await getFavorites();
    
    // Check if already exists
    if (!favorites.any((f) => f.itemId == favorite.itemId && f.type == favorite.type)) {
      favorites.add(favorite);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(int itemId, String type) async {
    final favorites = await getFavorites();
    favorites.removeWhere((f) => f.itemId == itemId && f.type == type);
    await _saveFavorites(favorites);
  }

  Future<bool> isFavorite(int itemId, String type) async {
    final favorites = await getFavorites();
    return favorites.any((f) => f.itemId == itemId && f.type == type);
  }

  Future<List<Favorite>> getFavoritesByType(String type) async {
    final favorites = await getFavorites();
    return favorites.where((f) => f.type == type).toList();
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }

  Future<void> _saveFavorites(List<Favorite> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites
        .map((favorite) => jsonEncode(favorite.toJson()))
        .toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }
}

