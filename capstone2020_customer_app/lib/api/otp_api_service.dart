import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/account_model.dart';
import 'package:capstone2020customerapp/models/login_model.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:chopper/chopper.dart';

import '../api_url_constain.dart';

part "otp_api_service.chopper.dart";

@ChopperApi(baseUrl: '/account/')
abstract class OTPApiService extends ChopperService{

  static OTPApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$OTPApiService()]
    );
    return _$OTPApiService(client);
  }

  @Get(path: "{username}/otp/{otp}/register")
  Future<Response> confirmOTPCode(@Path() String username, @Path() String otp);

  @Get(path: "{username}/otp/{otp}/forget")
  Future<Response> confirmOTPCodeForgetPassword(@Path() String username, @Path() String otp);

  @Get(path: "{accountId}/customer/forget")
  Future<Response> getTicketForgetPassword(@Path() String accountId);

  @Get(path: "{accountId}/newOtp")
  Future<Response> getNewOTP(@Path() String accountId);

}

class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.replace(
      body: fromJsonData<BodyType, InnerType>(response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}