// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    json['id'] as String,
    json['addressDelivery'] as String,
    json['marketName'] as String,
    json['note'] as String,
    json['shipper'] as String,
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
      'marketName': instance.marketName,
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
