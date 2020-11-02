import 'package:json_annotation/json_annotation.dart';
part 'order_detail_model.g.dart';

@JsonSerializable()
class OrderDetail{
  String id;
  String foodId;
  String image;
  double priceOriginal;
  double pricePaid;
  double weight;
  int saleOff;


  OrderDetail(
      this.id,
      this.foodId,
      this.image,
      this.priceOriginal,
      this.pricePaid,
      this.weight,
      this.saleOff,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}