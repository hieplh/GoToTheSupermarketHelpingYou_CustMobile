// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipper _$ShipperFromJson(Map<String, dynamic> json) {
  return Shipper(
    json['username'] as String,
    json['fullname'] as String,
    json['dob'] as String,
    json['role'] as String,
    json['numDelivery'] as int,
    json['numCancel'] as int,
    (json['wallet'] as num)?.toDouble(),
    json['vin'] as String,
  );
}

Map<String, dynamic> _$ShipperToJson(Shipper instance) => <String, dynamic>{
      'username': instance.username,
      'fullname': instance.fullname,
      'dob': instance.dob,
      'role': instance.role,
      'numDelivery': instance.numDelivery,
      'numCancel': instance.numCancel,
      'wallet': instance.wallet,
      'vin': instance.vin,
    };
