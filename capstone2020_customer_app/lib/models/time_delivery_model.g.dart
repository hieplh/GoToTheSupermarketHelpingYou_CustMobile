// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_delivery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeDelivery _$TimeDeliveryFromJson(Map<String, dynamic> json) {
  return TimeDelivery(
    json['day'] as int,
    json['hours'] as int,
    json['minutes'] as int,
    json['month'] as int,
    json['seconds'] as int,
    json['year'] as int,
  );
}

Map<String, dynamic> _$TimeDeliveryToJson(TimeDelivery instance) =>
    <String, dynamic>{
      'day': instance.day,
      'hours': instance.hours,
      'minutes': instance.minutes,
      'month': instance.month,
      'seconds': instance.seconds,
      'year': instance.year,
    };
