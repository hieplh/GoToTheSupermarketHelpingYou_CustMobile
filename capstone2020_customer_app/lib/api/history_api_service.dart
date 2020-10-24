import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:chopper/chopper.dart';

part "history_api_service.chopper.dart";

@ChopperApi(baseUrl: '/histories/customer/cust123/page/1')
abstract class HistoryApiService extends ChopperService{

  static HistoryApiService create(){
    final client = ChopperClient(
        baseUrl: 'http://10.1.147.226/smhu/api',
        services: [_$HistoryApiService()],
        converter: JsonToTypeConverter({
          History: (jsonData) => History.fromJson(jsonData)
        })
    );
    return _$HistoryApiService(client);
  }
  @Get()
  Future<Response<List<History>>> getAllHistory();


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