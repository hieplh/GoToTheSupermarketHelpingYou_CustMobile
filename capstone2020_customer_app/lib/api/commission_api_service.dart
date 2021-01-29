import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/account_model.dart';
import 'package:capstone2020customerapp/models/cost_model.dart';
import 'package:capstone2020customerapp/models/login_model.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:chopper/chopper.dart';

import '../api_url_constain.dart';

part "commission_api_service.chopper.dart";

@ChopperApi(baseUrl: '/service/')
abstract class CommissionApiService extends ChopperService{

  static CommissionApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL,
        services: [_$CommissionApiService()],
        converter: JsonToTypeConverter({
          CostModel: (jsonData) => CostModel.fromJson(jsonData)
        })
    );
    return _$CommissionApiService(client);
  }

  @Get(path: "{market_Id}/{dest_Address}/{delivery_Time}/{quantity}")
  Future<Response<CostModel>> getServiceCost(@Path() String market_Id, @Path() String dest_Address, @Path() String delivery_Time, @Path() int quantity);


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