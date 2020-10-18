// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodModel _$FoodModelFromJson(Map<String, dynamic> json) {
  return FoodModel(
    json['id'] as String,
    json['name'] as String,
    json['image'] as String,
    json['description'] as String,
    json['price'] as String,
    json['saleOff'] == null
        ? null
        : SaleOffModel.fromJson(json['saleOff'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FoodModelToJson(FoodModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'saleOff': instance.saleOff,
    };
