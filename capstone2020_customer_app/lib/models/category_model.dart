import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/models/saleoff_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel{
  String id;
  String description;
  List<FoodModel> foods;


  CategoryModel(
      this.id,
      this.description,
      this.foods
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}