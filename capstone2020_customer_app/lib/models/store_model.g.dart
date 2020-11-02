// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) {
  return StoreModel(
    json['id'] as String,
    json['name'] as String,
    json['addr1'] as String,
    json['addr2'] as String,
    json['addr3'] as String,
    json['addr4'] as String,
    json['lat'] as String,
    json['lng'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addr1': instance.addr1,
      'addr2': instance.addr2,
      'addr3': instance.addr3,
      'addr4': instance.addr4,
      'lat': instance.lat,
      'lng': instance.lng,
      'image': instance.image,
    };
