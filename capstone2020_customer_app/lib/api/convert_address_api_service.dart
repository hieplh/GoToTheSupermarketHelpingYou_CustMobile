import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/shipper_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/models/tracking_model.dart';
import 'package:chopper/chopper.dart';

part "convert_address_api_service.chopper.dart";

@ChopperApi(baseUrl: '')
abstract class ConvertAddressApiService extends ChopperService{

  static ConvertAddressApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$ConvertAddressApiService()],
        converter: JsonToTypeConverter({
          Tracking: (jsonData) => Tracking.fromJson(jsonData)
        })
    );
    return _$ConvertAddressApiService(client);
  }
  @Get(path: "/{address}")
  Future<Response<Tracking>> getLatLng(@Path() String address);

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