// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Market _$MarketFromJson(Map<String, dynamic> json) {
  return Market(
    json['image'] as String,
    json['name'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'id': instance.id,
    };
