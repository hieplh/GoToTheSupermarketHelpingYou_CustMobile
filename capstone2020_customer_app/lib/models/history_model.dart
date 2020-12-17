
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class History{
  String id;
  String addressDelivery;
  String marketName;
  String note;
  String shipper;
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
      this.marketName,
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