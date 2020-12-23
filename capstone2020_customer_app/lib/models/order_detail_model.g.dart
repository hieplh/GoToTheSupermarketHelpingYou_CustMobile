// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    json['id'] as String,
    json['food'] == null
        ? null
        : FoodModel.fromJson(json['food'] as Map<String, dynamic>),
    (json['priceOriginal'] as num)?.toDouble(),
    (json['pricePaid'] as num)?.toDouble(),
    (json['weight'] as num)?.toDouble(),
    json['saleOff'] as int,
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'food': instance.food,
      'priceOriginal': instance.priceOriginal,
      'pricePaid': instance.pricePaid,
      'weight': instance.weight,
      'saleOff': instance.saleOff,
    };
