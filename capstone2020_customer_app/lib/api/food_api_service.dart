import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:chopper/chopper.dart';

part "food_api_service.chopper.dart";

@ChopperApi(baseUrl: '/foods/')
abstract class FoodApiService extends ChopperService{

  static FoodApiService create(){
    final client = ChopperClient(
        baseUrl: 'http://10.1.133.199:1234/smhu/api',
        services: [_$FoodApiService()],
        converter: JsonToTypeConverter({
          FoodModel: (jsonData) => FoodModel.fromJson(jsonData)
        })
    );
    return _$FoodApiService(client);
  }
  @Get(path: "{store_id}")
  Future<Response<List<FoodModel>>> getAllFood(@Path() String store_id);
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