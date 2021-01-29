// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CostModel _$CostModelFromJson(Map<String, dynamic> json) {
  return CostModel(
    (json['costShipping'] as num)?.toDouble(),
    (json['costShopping'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CostModelToJson(CostModel instance) => <String, dynamic>{
      'costShipping': instance.costShipping,
      'costShopping': instance.costShopping,
    };
