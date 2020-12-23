
import 'package:capstone2020customerapp/models/shipper_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class History{
  String id;
  String addressDelivery;
  StoreModel market;
  String note;
  Shipper shipper;
  int status;
  String createDate;
  String createTime;
  String receiveTime;
  String deliveryTime;
  double costShopping;
  double costDelivery;
  double totalCost;



  History(
      this.id,
      this.addressDelivery,
      this.market,
      this.note,
      this.shipper,
      this.status,
      this.createDate,
      this.createTime,
      this.receiveTime,
      this.deliveryTime,
      this.costShopping,
      this.costDelivery,
      this.totalCost,
      );

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}