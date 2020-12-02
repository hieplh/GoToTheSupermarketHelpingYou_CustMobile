import 'package:json_annotation/json_annotation.dart';
part 'tracking_model.g.dart';

@JsonSerializable()
class Tracking{
  String lng;
  String lat;


  Tracking(
      this.lng,
      this.lat,
      );

  factory Tracking.fromJson(Map<String, dynamic> json) =>
      _$TrackingFromJson(json);

  Map<String, dynamic> toJson() => _$TrackingToJson(this);
}