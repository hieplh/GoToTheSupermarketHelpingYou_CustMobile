import 'package:capstone2020customerapp/models/addr_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'cost_model.g.dart';

@JsonSerializable()
class CostModel{
  double costShipping;
  double costShopping;


  CostModel(
      this.costShipping,
      this.costShopping
      );

  factory CostModel.fromJson(Map<String, dynamic> json) =>
      _$CostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CostModelToJson(this);

}