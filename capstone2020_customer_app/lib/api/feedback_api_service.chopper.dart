// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FeedbackApiService extends FeedbackApiService {
  _$FeedbackApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FeedbackApiService;

  @override
  Future<Response<dynamic>> getFeedback(
      String order_id, String content, String rating) {
    final $url = '/feedback/$order_id/$content/$rating';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
