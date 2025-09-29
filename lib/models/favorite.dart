import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite {
  final int id;
  final String type; // 'match', 'team', 'player'
  final int itemId;
  final String name;
  final String? imageUrl;
  final DateTime addedAt;

  const Favorite({
    required this.id,
    required this.type,
    required this.itemId,
    required this.name,
    this.imageUrl,
    required this.addedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  Favorite copyWith({
    int? id,
    String? type,
    int? itemId,
    String? name,
    String? imageUrl,
    DateTime? addedAt,
  }) {
    return Favorite(
      id: id ?? this.id,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

