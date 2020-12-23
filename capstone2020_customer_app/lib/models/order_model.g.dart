// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as String,
    json['cust'] as String,
    json['addressDelivery'] as String,
    json['note'] as String,
    json['market'] == null
        ? null
        : StoreModel.fromJson(json['market'] as Map<String, dynamic>),
    json['shipper'] == null
        ? null
        : Shipper.fromJson(json['shipper'] as Map<String, dynamic>),
    json['createDate'] as String,
    json['createTime'] as String,
    json['status'] as int,
    (json['costShopping'] as num)?.toDouble(),
    (json['costDelivery'] as num)?.toDouble(),
    (json['totalCost'] as num)?.toDouble(),
    (json['refundCost'] as num)?.toDouble(),
    json['dateDelivery'] as String,
    json['timeDelivery'] as String,
    (json['details'] as List)
        ?.map((e) =>
            e == null ? null : OrderDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'cust': instance.cust,
      'addressDelivery': instance.addressDelivery,
      'note': instance.note,
      'market': instance.market,
      'shipper': instance.shipper,
      'createDate': instance.createDate,
      'createTime': instance.createTime,
      'status': instance.status,
      'costShopping': instance.costShopping,
      'costDelivery': instance.costDelivery,
      'totalCost': instance.totalCost,
      'refundCost': instance.refundCost,
      'dateDelivery': instance.dateDelivery,
      'timeDelivery': instance.timeDelivery,
      'details': instance.details,
    };
