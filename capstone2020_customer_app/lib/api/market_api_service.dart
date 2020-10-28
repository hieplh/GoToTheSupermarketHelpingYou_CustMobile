import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/market_model.dart';
import 'package:chopper/chopper.dart';

part "market_api_service.chopper.dart";

@ChopperApi(baseUrl: '/corporations/all')
abstract class MarketApiService extends ChopperService{

  static MarketApiService create(){
    final client = ChopperClient(
        baseUrl: 'http://smhu.ddns.net/smhu/api',
        services: [_$MarketApiService()],
        converter: JsonToTypeConverter({
          Market: (jsonData) => Market.fromJson(jsonData)
        })
    );
    return _$MarketApiService(client);
  }
  @Get()
  Future<Response<List<Market>>> getAllBranchMarket();

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