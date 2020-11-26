import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:chopper/chopper.dart';

import '../api_url_constain.dart';

part "history_api_service.chopper.dart";

@ChopperApi(baseUrl: '')
abstract class HistoryApiService extends ChopperService{

  static HistoryApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$HistoryApiService()],
        converter: JsonToTypeConverter({
          History: (jsonData) => History.fromJson(jsonData),
          OrderDetail: (jsonData) => OrderDetail.fromJson(jsonData)
        })
    );
    return _$HistoryApiService(client);
  }
  @Get(path: "/histories/customer/{cust_id}/page/1")
  Future<Response<List<History>>> getAllHistory(@Path() String cust_id);
  @Get(path: "/history/{order_id}")
  Future<Response<List<OrderDetail>>> getHistoryDetail(@Path() String order_id);

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