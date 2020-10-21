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
  Future<Response<List<History>>> getAllHistory() {
    final $url = '/histories/cust/cust123/page/1';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<History>, History>($request);
  }
}
