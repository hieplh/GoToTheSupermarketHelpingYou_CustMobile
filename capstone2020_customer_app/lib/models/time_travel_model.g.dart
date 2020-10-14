// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_travel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTravel _$TimeTravelFromJson(Map<String, dynamic> json) {
  return TimeTravel(
    json['delivery'] as String,
    json['going'] as String,
    json['shopping'] as String,
    json['traffic'] as String,
  );
}

Map<String, dynamic> _$TimeTravelToJson(TimeTravel instance) =>
    <String, dynamic>{
      'delivery': instance.delivery,
      'going': instance.going,
      'shopping': instance.shopping,
      'traffic': instance.traffic,
    };
