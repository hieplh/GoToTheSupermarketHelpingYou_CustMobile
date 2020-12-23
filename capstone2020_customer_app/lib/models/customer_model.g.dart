// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['username'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['phone'] as String,
    json['dob'] as String,
    json['role'] as String,
    json['numSuccess'] as int,
    json['numCancel'] as int,
    (json['wallet'] as num)?.toDouble(),
    (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : AddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'dob': instance.dob,
      'role': instance.role,
      'numSuccess': instance.numSuccess,
      'numCancel': instance.numCancel,
      'wallet': instance.wallet,
      'addresses': instance.addresses,
    };
