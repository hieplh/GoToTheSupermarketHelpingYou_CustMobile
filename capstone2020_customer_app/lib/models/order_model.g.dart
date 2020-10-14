// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    (json['costDelivery'] as num)?.toDouble(),
    (json['costShopping'] as num)?.toDouble(),
    json['cust'] as String,
    json['dateDelivery'] as String,
    json['details'] == null
        ? null
        : OrderDetail.fromJson(json['details'] as Map<String, dynamic>),
    json['market'] as String,
    json['note'] as String,
    json['timeDelivery'] as String,
    json['timeTravel'] == null
        ? null
        : TimeTravel.fromJson(json['timeTravel'] as Map<String, dynamic>),
    (json['totalCost'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'costDelivery': instance.costDelivery,
      'costShopping': instance.costShopping,
      'cust': instance.cust,
      'dateDelivery': instance.dateDelivery,
      'details': instance.details,
      'market': instance.market,
      'note': instance.note,
      'timeDelivery': instance.timeDelivery,
      'timeTravel': instance.timeTravel,
      'totalCost': instance.totalCost,
    };
