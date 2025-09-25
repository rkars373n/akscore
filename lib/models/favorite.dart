import 'package:isar/isar.dart';

part 'favorite.g.dart';

@collection
class Favorite {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  String? type; // 'match', 'team', or 'player'

  @Index(type: IndexType.value, caseSensitive: false)
  String? itemId;

  DateTime? createdAt;
}
