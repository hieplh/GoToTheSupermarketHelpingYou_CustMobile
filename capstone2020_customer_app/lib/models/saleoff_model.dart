import 'package:json_annotation/json_annotation.dart';
part 'saleoff_model.g.dart';

@JsonSerializable()
class SaleOffModel{
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String saleOff;


  SaleOffModel(
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.saleOff,

      );

  factory SaleOffModel.fromJson(Map<String, dynamic> json) =>
      _$SaleOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaleOffModelToJson(this);
}