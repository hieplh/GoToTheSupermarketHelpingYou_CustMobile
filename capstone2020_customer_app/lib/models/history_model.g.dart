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
    json['createDate'] as String,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'addressDelivery': instance.addressDelivery,
      'marketName': instance.marketName,
      'createDate': instance.createDate,
      'createTime': instance.createTime,
    };
