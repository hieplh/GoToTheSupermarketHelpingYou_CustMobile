import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'addr_model.g.dart';

@JsonSerializable()
class AddressModel{
  String addr1;
  String addr2;
  String addr3;
  String addr4;

  AddressModel(
      this.addr1,
      this.addr2,
      this.addr3,
      this.addr4,

      );

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

}