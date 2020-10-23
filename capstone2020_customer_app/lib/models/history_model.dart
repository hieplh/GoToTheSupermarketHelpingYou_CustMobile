
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class History{
  String id;
  String addressDelivery;
  String marketName;
  String note;
  String shipper;
  String createDate;
  String createTime;
  double costShopping;
  double costDelivery;
  double totalCost;



  History(
      this.id,
      this.addressDelivery,
      this.marketName,
      this.note,
      this.shipper,
      this.createDate,
      this.createTime,
      this.costShopping,
      this.costDelivery,
      this.totalCost,
      );

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}