// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    json['username'] as String,
  )
    ..password = json['password'] as String
    ..role = json['role'] as String;
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'password': instance.password,
      'role': instance.role,
      'username': instance.username,
    };
