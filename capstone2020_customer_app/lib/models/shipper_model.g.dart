// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipper _$ShipperFromJson(Map<String, dynamic> json) {
  return Shipper(
    json['id'] as String,
    json['username'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['dob'] as String,
    json['role'] as String,
    json['numDelivery'] as int,
    json['numCancel'] as int,
    (json['wallet'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ShipperToJson(Shipper instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob,
      'role': instance.role,
      'numDelivery': instance.numDelivery,
      'numCancel': instance.numCancel,
      'wallet': instance.wallet,
    };
