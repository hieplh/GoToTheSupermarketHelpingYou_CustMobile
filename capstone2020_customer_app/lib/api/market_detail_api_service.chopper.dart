// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_detail_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MarketDetailApiService extends MarketDetailApiService {
  _$MarketDetailApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MarketDetailApiService;

  @override
  Future<Response<StoreModel>> getStoreByID(String store_id) {
    final $url = '/market/$store_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<StoreModel, StoreModel>($request);
  }
}
