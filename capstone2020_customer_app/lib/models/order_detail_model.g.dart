// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
    json['food'] as String,
    (json['priceOriginal'] as num)?.toDouble(),
    (json['pricePaid'] as num)?.toDouble(),
    json['saleOff'] as int,
    (json['weight'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'food': instance.food,
      'priceOriginal': instance.priceOriginal,
      'pricePaid': instance.pricePaid,
      'saleOff': instance.saleOff,
      'weight': instance.weight,
    };
