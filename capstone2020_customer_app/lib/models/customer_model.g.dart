// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    json['id'] as String,
    json['username'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['dob'] as String,
    json['role'] as String,
    json['numSuccess'] as int,
    json['numCancel'] as int,
    (json['wallet'] as num)?.toDouble(),
    json['addressModel'] == null
        ? null
        : AddressModel.fromJson(json['addressModel'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob,
      'role': instance.role,
      'numSuccess': instance.numSuccess,
      'numCancel': instance.numCancel,
      'wallet': instance.wallet,
      'addressModel': instance.addressModel,
    };
