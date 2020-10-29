import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:chopper/chopper.dart';

part "store_api_service.chopper.dart";

@ChopperApi(baseUrl: '/markets/')
abstract class StoreApiService extends ChopperService{

  static StoreApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$StoreApiService()],
        converter: JsonToTypeConverter({
          StoreModel: (jsonData) => StoreModel.fromJson(jsonData)
        })
    );
    return _$StoreApiService(client);
  }
  @Get(path: "{store_id}")
  Future<Response<List<StoreModel>>> getAllStore(@Path() String store_id);

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