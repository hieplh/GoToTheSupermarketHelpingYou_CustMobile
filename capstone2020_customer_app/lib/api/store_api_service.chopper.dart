// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$StoreApiService extends StoreApiService {
  _$StoreApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = StoreApiService;

  @override
  Future<Response<List<StoreModel>>> getAllStore(String store_id) {
    final $url = '/markets/$store_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<StoreModel>, StoreModel>($request);
  }
}
