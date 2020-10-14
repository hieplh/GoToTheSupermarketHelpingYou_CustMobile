import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class Order{
  double costDelivery;
  double costShopping;
  String cust;
  String dateDelivery;
  OrderDetail details;
//  String lat;
//  String lng;
  String market;
  String note;
  String timeDelivery;
  TimeTravel timeTravel;
  double totalCost;

  Order(
      this.costDelivery,
      this.costShopping,
      this.cust,
      this.dateDelivery,
      this.details,
      this.market,
      this.note,
      this.timeDelivery,
      this.timeTravel,
      this.totalCost,
      );

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

}