// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saleoff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleOffModel _$SaleOffModelFromJson(Map<String, dynamic> json) {
  return SaleOffModel(
    json['startDate'] as String,
    json['endDate'] as String,
    json['startTime'] as String,
    json['endTime'] as String,
    json['saleOff'] as int,
  );
}

Map<String, dynamic> _$SaleOffModelToJson(SaleOffModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'saleOff': instance.saleOff,
    };
