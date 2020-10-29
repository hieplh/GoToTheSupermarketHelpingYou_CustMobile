import 'dart:async';
import 'dart:convert';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/order_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:chopper/chopper.dart';

import '../api_url_constain.dart';

part "order_api_service.chopper.dart";

@ChopperApi(baseUrl: '/order/')
abstract class OrderApiService extends ChopperService{

  static OrderApiService create(){
    final client = ChopperClient(
        baseUrl: API_URL_STARTPOINT,
        services: [_$OrderApiService()],
        converter: JsonToTypeConverter({
          Order: (jsonData) => Order.fromJson(jsonData)
        })
    );
    return _$OrderApiService(client);
  }
//  @Post()
//  Future<Response> postOrder(@Query() double costDelivery, @Query() double costShopping, @Query() String cust,
//  @Query() String dateDelivery, @Query() List<OrderDetail> details, @Query() String market, @Query() String note,
//  @Query() String timeDelivery, @Query() TimeTravel timeTravel, @Query() double totalCost);
  @Get(path: "{id}")
  Future<Response<Order>> getOrderByID(@Path() String id);

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