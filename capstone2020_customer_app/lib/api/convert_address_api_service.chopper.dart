// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_address_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ConvertAddressApiService extends ConvertAddressApiService {
  _$ConvertAddressApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ConvertAddressApiService;

  @override
  Future<Response<Tracking>> getLatLng(String address) {
    final $url = '/$address';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Tracking, Tracking>($request);
  }
}
