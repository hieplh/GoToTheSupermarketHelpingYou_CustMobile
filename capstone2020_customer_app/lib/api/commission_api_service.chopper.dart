// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CommissionApiService extends CommissionApiService {
  _$CommissionApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CommissionApiService;

  @override
  Future<Response<CostModel>> getServiceCost(String market_Id,
      String dest_Address, String delivery_Time, int quantity) {
    final $url = '/service/$market_Id/$dest_Address/$delivery_Time/$quantity';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<CostModel, CostModel>($request);
  }
}
