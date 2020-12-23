// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FoodApiService extends FoodApiService {
  _$FoodApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FoodApiService;

  @override
  Future<Response<List<CategoryModel>>> getAllFood(String store_id) {
    final $url = '/foods/$store_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<CategoryModel>, CategoryModel>($request);
  }

  @override
  Future<Response<FoodModel>> getFoodDetail(String store_id, String food_id) {
    final $url = '/food/$store_id/$food_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<FoodModel, FoodModel>($request);
  }
}
