// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$HistoryApiService extends HistoryApiService {
  _$HistoryApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HistoryApiService;

  @override
  Future<Response<List<History>>> getAllHistory(String cust_id) {
    final $url = '/histories/customer/$cust_id/page/0';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<History>, History>($request);
  }

  @override
  Future<Response<List<OrderDetail>>> getHistoryDetail(String order_id) {
    final $url = '/history/$order_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<OrderDetail>, OrderDetail>($request);
  }
}
