// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    json['id'] as String,
    json['addressDelivery'] as String,
    json['market'] == null
        ? null
        : StoreModel.fromJson(json['market'] as Map<String, dynamic>),
    json['note'] as String,
    json['shipper'] == null
        ? null
        : Shipper.fromJson(json['shipper'] as Map<String, dynamic>),
    json['status'] as int,
    json['createDate'] as String,
    json['createTime'] as String,
    json['receiveTime'] as String,
    json['deliveryTime'] as String,
    (json['costShopping'] as num)?.toDouble(),
    (json['costDelivery'] as num)?.toDouble(),
    (json['totalCost'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'addressDelivery': instance.addressDelivery,
      'market': instance.market,
      'note': instance.note,
      'shipper': instance.shipper,
      'status': instance.status,
      'createDate': instance.createDate,
      'createTime': instance.createTime,
      'receiveTime': instance.receiveTime,
      'deliveryTime': instance.deliveryTime,
      'costShopping': instance.costShopping,
      'costDelivery': instance.costDelivery,
      'totalCost': instance.totalCost,
    };
