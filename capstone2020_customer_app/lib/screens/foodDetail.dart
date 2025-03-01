import 'dart:convert';

import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/category_model.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_url_constain.dart';

class FoodDetailPage extends StatefulWidget {
  final String foodID;

  FoodDetailPage({Key key, @required this.foodID}) : super(key: key);
  @override
  _FoodDetailPage createState() => _FoodDetailPage(foodID);
}

FocusNode myFocusNode = new FocusNode();

class _FoodDetailPage extends State<FoodDetailPage> {
  String foodID;
  _FoodDetailPage(this.foodID);
  int count = 0;
  void showToast() {
    Fluttertoast.showToast(
        msg: 'Thêm Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );

  }

  FoodModel food;
  List<CategoryModel> category;
  List<FoodModel> foodList = new List();
  Future<void> getFoodDetail() async {
    print('foodID: ' + foodID);
    if(foodID.contains(" ") == false){
      final myService = FoodApiService.create();
      final response = await myService.getFoodDetail(idStore, foodID);

      food = response.body;
    }else{
      final myService1 = FoodApiService.create();
      final response1 = await myService1.getAllFood(idStore);
      category = response1.body;

      for(var cate in category){
        foodList += cate.foods;
      }
      for(var list in foodList){
        if(utf8.decode(latin1.encode(list.name), allowMalformed: true) == foodID){
          food = list;
        }
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
          future: getFoodDetail(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildHeader(),
                    _buildBody(),
                    _buildOrderButton(),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300.0,
      child: Image.network(
        '${food.image}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              if(food.saleOff.saleOff == 0)
                Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  '${utf8.decode(latin1.encode(food.name), allowMalformed: true)} - ${oCcy.format(food.price)}đ',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              if(food.saleOff.saleOff != 0)
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    '${utf8.decode(latin1.encode(food.name), allowMalformed: true)} - ${oCcy.format(food.price - (food.price*food.saleOff.saleOff/100))}đ',
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
              if(food.saleOff.saleOff != 0)
                Container(
                padding: const EdgeInsets.only(top: 5.0),
                alignment: Alignment.center,
                child: Text(
                  'Giá gốc: ${oCcy.format(food.price)}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Special Instructions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  'Optional',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
          child: TextFormField(
              //onChanged: bloc.emailChanged,
              style: TextStyle(
                color: Colors.black,
              ),
              //controller: searchController,
              //onSaved: (input) => search = input,
              decoration: InputDecoration(
                labelText: 'E.g. Tôi không cần túi nhựa',
//                labelStyle: TextStyle(
//                    color: myFocusNode.hasFocus
//                        ? const Color.fromRGBO(0, 255, 0, 1)
//                        : Colors.grey),
              ),
            ),
        ),
      ],
    );
  }

//  Widget _buildQuantity() {
//    return Container(
//      child: new Center(
//        child: new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            new FloatingActionButton(
//              onPressed: add,
//              child: new Icon(Icons.add,
//                  color: const Color.fromRGBO(0, 141, 177, 1)),
//              backgroundColor: Colors.white,
//            ),
//            new Text('$_n', style: new TextStyle(fontSize: 60.0)),
//            new FloatingActionButton(
//              onPressed: minus,
//              child: new Icon(
//                  const IconData(0xe15b, fontFamily: 'MaterialIcons'),
//                  color: const Color.fromRGBO(0, 141, 177, 1)),
//              backgroundColor: Colors.white,
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _buildOrderButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(top: 10.0),
      height: 60.0,
      child: RaisedButton(
        onPressed: () {
          Data data = new Data('${food.id}','${food.image}', '${food.name}', '${food.price}', 1, food);
          total = total + (double.parse(data.price.toString()) - (double.parse(data.price)*data.foods.saleOff.saleOff/100));
          if(listCart.length == 0){
            listCart.add(data);
            badgeData++;
          }else{
            for(int i = 0; i < listCart.length; i++){
              if(foodID == listCart[i].id){
                count = i;
                print(count);
                break;
              }else{
                if(foodID != listCart[i].id){
                  //listCart[i].quantity++;
                  count = -1;
                }
              }
            }
            if(count == -1){
              listCart.add(data);
              badgeData++;
            }else{
              listCart[count].quantity++;
            }
          }
          quantity.putIfAbsent(data.id, () => data.quantity);
          showToast();
          Navigator.of(context).pop(MaterialPageRoute(builder: (context) {
            return HomePage(storeID: idStore,);
          }));
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
          child: Text(
            'Thêm Vào Giỏ Hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.0,
              letterSpacing: 2.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
    );
  }
}
