import 'package:capstone2020customerapp/models/saleoff_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'food_model.g.dart';

@JsonSerializable()
class FoodModel{
  String id;
  String name;
  String image;
  String description;
  String price;
  SaleOffModel saleOff;


  FoodModel(
      this.id,
      this.name,
      this.image,
      this.description,
      this.price,
      this.saleOff,
      );

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodModelToJson(this);
}