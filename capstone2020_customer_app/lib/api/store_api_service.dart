import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:chopper/chopper.dart';

part "store_api_service.chopper.dart";

@ChopperApi(baseUrl: '/malls')
abstract class StoreApiService extends ChopperService{

  static StoreApiService create(){
    final client = ChopperClient(
        baseUrl: 'https://smhu.azurewebsites.net/smhu/api',
        services: [_$StoreApiService()],
        converter: JsonToTypeConverter({
          StoreModel: (jsonData) => StoreModel.fromJson(jsonData)
        })
    );
    return _$StoreApiService(client);
  }
  @Get()
  Future<Response<List<StoreModel>>> getAllStore();


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