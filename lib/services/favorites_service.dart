import 'package:akscore/models/favorite.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesService {
  late Future<Isar> _db;

  FavoritesService() {
    _db = _openDb();
  }

  Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.
      open(
        [FavoriteSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> addFavorite(String itemId, String type) async {
    final isar = await _db;
    final isAlreadyFavorite = await isFavorite(itemId, type);
    if (!isAlreadyFavorite) {
      final favorite = Favorite()
        ..itemId = itemId
        ..type = type
        ..createdAt = DateTime.now();
      await isar.writeTxn(() => isar.favorites.put(favorite));
    }
  }

  Future<void> removeFavorite(String itemId, String type) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.favorites.filter().itemIdEqualTo(itemId).and().typeEqualTo(type).deleteAll());
  }

  Future<bool> isFavorite(String itemId, String type) async {
    final isar = await _db;
    final favorite = await isar.favorites.filter().itemIdEqualTo(itemId).and().typeEqualTo(type).findFirst();
    return favorite != null;
  }

  Future<List<String>> getFavoriteIds(String type) async {
    final isar = await _db;
    final favorites = await isar.favorites.filter().typeEqualTo(type).findAll();
    return favorites.map((e) => e.itemId!).toList();
  }

  Stream<List<Favorite>> watchFavorites(String type) async* {
    final isar = await _db;
    yield* isar.favorites.filter().typeEqualTo(type).watch(fireImmediately: true);
  }

  Future<Map<String, int>> getFavoritesCount() async {
    final isar = await _db;
    final matches = await isar.favorites.filter().typeEqualTo('match').count();
    final teams = await isar.favorites.filter().typeEqualTo('team').count();
    final players = await isar.favorites.filter().typeEqualTo('player').count();
    
    return {
      'matches': matches,
      'teams': teams,
      'players': players,
    };
  }

  Future<void> clearAllFavorites() async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.favorites.clear();
    });
  }
}
