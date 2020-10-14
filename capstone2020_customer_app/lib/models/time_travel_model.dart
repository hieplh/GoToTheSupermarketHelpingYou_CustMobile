import 'package:json_annotation/json_annotation.dart';
part 'time_travel_model.g.dart';

@JsonSerializable()
class TimeTravel{
  String delivery;
  String going;
  String shopping;
  String traffic;

  TimeTravel(
      this.delivery,
      this.going,
      this.shopping,
      this.traffic,
      );

  factory TimeTravel.fromJson(Map<String, dynamic> json) =>
      _$TimeTravelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTravelToJson(this);
}