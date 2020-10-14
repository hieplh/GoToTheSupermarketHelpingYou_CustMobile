import 'package:json_annotation/json_annotation.dart';
part 'time_delivery_model.g.dart';

@JsonSerializable()
class TimeDelivery{
  int day;
  int hours;
  int minutes;
  int month;
  int seconds;
  int year;

  TimeDelivery(
      this.day,
      this.hours,
      this.minutes,
      this.month,
      this.seconds,
      this.year,
      );
  factory TimeDelivery.fromJson(Map<String, dynamic> json) =>
      _$TimeDeliveryFromJson(json);

  Map<String, dynamic> toJson() => _$TimeDeliveryToJson(this);
}