// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    json['addr1'] as String,
    json['addr2'] as String,
    json['addr3'] as String,
    json['addr4'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'addr1': instance.addr1,
      'addr2': instance.addr2,
      'addr3': instance.addr3,
      'addr4': instance.addr4,
    };
