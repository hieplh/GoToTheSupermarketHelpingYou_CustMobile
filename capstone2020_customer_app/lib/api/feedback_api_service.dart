import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/models/tracking_model.dart';
import 'package:chopper/chopper.dart';

part "feedback_api_service.chopper.dart";

@ChopperApi(baseUrl: '/feedback/')
abstract class FeedbackApiService extends ChopperService{

  static FeedbackApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$FeedbackApiService()],

    );
    return _$FeedbackApiService(client);
  }
  @Get(path: "{order_id}/{content}/{rating}")
  Future<Response> getFeedback(@Path() String order_id, @Path() String content, @Path() int rating);

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