import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/account_model.dart';
import 'package:capstone2020customerapp/models/login_model.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:chopper/chopper.dart';

import '../api_url_constain.dart';

part "login_api_service.chopper.dart";

@ChopperApi(baseUrl: '/account/')
abstract class LoginApiService extends ChopperService{

  static LoginApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$LoginApiService()],
        converter: JsonToTypeConverter({
          Account: (jsonData) => Account.fromJson(jsonData)
        })
    );
    return _$LoginApiService(client);
  }
  @Post(path: "username")
  Future<Response<Account>> postAccount(@Body() Map<String, dynamic> body);

  @Get(path: "{accountId}/wallet/{amount}")
  Future<Response> updateWallet(@Path() String accountId, @Path() String amount);
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