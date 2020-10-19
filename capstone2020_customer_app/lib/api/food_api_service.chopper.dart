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
  Future<Response<List<FoodModel>>> getAllFood(String store_id) {
    final $url = '/foods/$store_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<FoodModel>, FoodModel>($request);
  }
}
