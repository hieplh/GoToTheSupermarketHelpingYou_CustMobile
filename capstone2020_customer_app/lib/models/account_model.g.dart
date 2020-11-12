// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['id'] as String,
    json['username'] as String,
    json['firstName'] as String,
    json['middleName'] as String,
    json['lastName'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['dob'] as String,
    json['role'] as String,
    json['numCancel'] as int,
    json['numSuccess'] as int,
    (json['wallet'] as num)?.toDouble(),
    (json['addresses'] as List)
        ?.map((e) =>
            e == null ? null : AddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
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
      'addresses': instance.addresses,
    };
