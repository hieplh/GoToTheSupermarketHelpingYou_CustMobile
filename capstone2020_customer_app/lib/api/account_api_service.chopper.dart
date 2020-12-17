// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AccountApiService extends AccountApiService {
  _$AccountApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AccountApiService;

  @override
  Future<Response<Shipper>> getShipperByID(String accountId) {
    final $url = '/account/$accountId/shipper';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Shipper, Shipper>($request);
  }

  @override
  Future<Response<Customer>> getCustomerByID(String accountId) {
    final $url = '/account/$accountId/customer';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Customer, Customer>($request);
  }
}
