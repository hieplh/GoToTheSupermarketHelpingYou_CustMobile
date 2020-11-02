import 'package:json_annotation/json_annotation.dart';
part 'store_model.g.dart';

@JsonSerializable()
class StoreModel{
  String id;
  String name;
  String addr1;
  String addr2;
  String addr3;
  String addr4;
  String lat;
  String lng;
  String image;

  StoreModel(
      this.id,
      this.name,
      this.addr1,
      this.addr2,
      this.addr3,
      this.addr4,
      this.lat,
      this.lng,
      this.image,
      );

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}