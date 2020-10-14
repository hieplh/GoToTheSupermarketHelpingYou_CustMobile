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
  Future<Response<dynamic>> postOrder(
      double costDelivery,
      double costShopping,
      String cust,
      String dateDelivery,
      List<OrderDetail> details,
      String market,
      String note,
      String timeDelivery,
      TimeTravel timeTravel,
      double totalCost) {
    final $url = '/order';
    final $params = <String, dynamic>{
      'costDelivery': costDelivery,
      'costShopping': costShopping,
      'cust': cust,
      'dateDelivery': dateDelivery,
      'details': details,
      'market': market,
      'note': note,
      'timeDelivery': timeDelivery,
      'timeTravel': timeTravel,
      'totalCost': totalCost
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
