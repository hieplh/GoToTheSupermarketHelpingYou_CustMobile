// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MarketApiService extends MarketApiService {
  _$MarketApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MarketApiService;

  @override
  Future<Response<List<Market>>> getAllBranchMarket() {
    final $url = '/corporations/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Market>, Market>($request);
  }
}
