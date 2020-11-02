// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    json['id'] as String,
    json['foodId'] as String,
    json['image'] as String,
    (json['priceOriginal'] as num)?.toDouble(),
    (json['pricePaid'] as num)?.toDouble(),
    (json['weight'] as num)?.toDouble(),
    json['saleOff'] as int,
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foodId': instance.foodId,
      'image': instance.image,
      'priceOriginal': instance.priceOriginal,
      'pricePaid': instance.pricePaid,
      'weight': instance.weight,
      'saleOff': instance.saleOff,
    };
