// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$LoginApiService extends LoginApiService {
  _$LoginApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LoginApiService;

  @override
  Future<Response<Account>> postAccount(Map<String, dynamic> body) {
    final $url = '/account/username';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Account, Account>($request);
  }

  @override
  Future<Response<dynamic>> updateWallet(String accountId, String amount) {
    final $url = '/account/$accountId/wallet/$amount';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
