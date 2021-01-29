// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['username'] as String,
    json['fullname'] as String,
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
      'username': instance.username,
      'fullname': instance.fullname,
      'dob': instance.dob,
      'role': instance.role,
      'numSuccess': instance.numSuccess,
      'numCancel': instance.numCancel,
      'wallet': instance.wallet,
      'addresses': instance.addresses,
    };
