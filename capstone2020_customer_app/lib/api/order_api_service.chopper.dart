// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$OrderApiService extends OrderApiService {
  _$OrderApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = OrderApiService;

  @override
  Future<Response<Order>> getOrderByID(String id) {
    final $url = '/order/customer/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Order, Order>($request);
  }

  @override
  Future<Response<Order>> deleteOrder(String order_id, String id) {
    final $url = '/delete/$order_id/customer/$id';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<Order, Order>($request);
  }
}
