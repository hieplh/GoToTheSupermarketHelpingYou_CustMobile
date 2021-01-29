// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$OTPApiService extends OTPApiService {
  _$OTPApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = OTPApiService;

  @override
  Future<Response<dynamic>> confirmOTPCode(String username, String otp) {
    final $url = '/account/$username/otp/$otp/register';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmOTPCodeForgetPassword(
      String username, String otp) {
    final $url = '/account/$username/otp/$otp/forget';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTicketForgetPassword(String accountId) {
    final $url = '/account/$accountId/customer/forget';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNewOTP(String accountId) {
    final $url = '/account/$accountId/newOtp';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
