import 'package:akscore/models/favorite.dart';
import 'package:akscore/models/match.dart';
import 'package:akscore/models/player.dart';
import 'package:akscore/models/team.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      isar = await Isar.open(
        [
          FavoriteSchema,
          MatchSchema,
          PlayerSchema,
          TeamSchema,
        ],
        directory: dir.path,
      );
    }
  }
}
