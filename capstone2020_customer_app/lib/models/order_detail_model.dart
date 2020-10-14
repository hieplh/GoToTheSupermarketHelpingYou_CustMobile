import 'package:json_annotation/json_annotation.dart';
part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetail{
  String food;
  double priceOriginal;
  double pricePaid;
  int saleOff;
  double weight;

  OrderDetail(
      this.food,
      this.priceOriginal,
      this.pricePaid,
      this.saleOff,
      this.weight,
      )

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}