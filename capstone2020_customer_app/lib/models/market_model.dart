import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'market_model.g.dart';

@JsonSerializable()
class Market{
  String name;
  String id;

  Market(
      this.name,
      this.id,
      );

  factory Market.fromJson(Map<String, dynamic> json) =>
      _$MarketFromJson(json);

  Map<String, dynamic> toJson() => _$MarketToJson(this);

}