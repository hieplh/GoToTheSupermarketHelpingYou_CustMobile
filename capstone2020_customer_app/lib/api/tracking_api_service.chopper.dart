// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TrackingApiService extends TrackingApiService {
  _$TrackingApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TrackingApiService;

  @override
  Future<Response<Tracking>> getTracking(String order_id) {
    final $url = '/tracking/$order_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Tracking, Tracking>($request);
  }
}
