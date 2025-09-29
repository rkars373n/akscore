// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      itemId: (json['itemId'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'itemId': instance.itemId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'addedAt': instance.addedAt.toIso8601String(),
    };
