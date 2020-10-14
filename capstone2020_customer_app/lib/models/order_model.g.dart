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
    json['dateDelivery'] == null
        ? null
        : DateTime.parse(json['dateDelivery'] as String),
    json['details'] == null
        ? null
        : OrderDetail.fromJson(json['details'] as Map<String, dynamic>),
    json['market'] as String,
    json['note'] as String,
    (json['totalCost'] as num)?.toDouble(),
  )..timeDelivery = json['timeDelivery'] == null
      ? null
      : TimeDelivery.fromJson(json['timeDelivery'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'costDelivery': instance.costDelivery,
      'costShopping': instance.costShopping,
      'cust': instance.cust,
      'dateDelivery': instance.dateDelivery?.toIso8601String(),
      'details': instance.details,
      'market': instance.market,
      'note': instance.note,
      'timeDelivery': instance.timeDelivery,
      'totalCost': instance.totalCost,
    };
