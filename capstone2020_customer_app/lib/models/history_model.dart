
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class History{
  String id;
  String addressDelivery;
  String marketName;
  String createDate;
  String createTime;



  History(
      this.id,
      this.addressDelivery,
      this.marketName,
      this.createDate,
      this.createTime,
      );

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}