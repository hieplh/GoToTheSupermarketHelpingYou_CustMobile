import 'package:capstone2020customerapp/models/shipper_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'order_detail_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class Order{
  String id;
  String cust;
  String addressDelivery;
  String note;
  StoreModel market;
  Shipper shipper;
  String createDate;
  String createTime;
  int status;
  double costShopping;
  double costDelivery;
  double totalCost;
  double refundCost;
  String dateDelivery;
  String timeDelivery;
  List<OrderDetail> details;
//  String lat;
//  String lng;

  Order(
      this.id,
      this.cust,
      this.addressDelivery,
      this.note,
      this.market,
      this.shipper,
      this.createDate,
      this.createTime,
      this.status,
      this.costShopping,
      this.costDelivery,
      this.totalCost,
      this.refundCost,
      this.dateDelivery,
      this.timeDelivery,
      this.details,
      );

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

}