import 'dart:convert';

import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/bloc/cart_items_bloc.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/category_model.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_url_constain.dart';
import 'foodDetail.dart';

class FoodPage extends StatefulWidget {
  final String storeID;

  FoodPage({Key key, @required this.storeID}) : super(key: key);
  @override
  _FoodPage createState() => _FoodPage(storeID);
}

class _FoodPage extends State<FoodPage> {
  String storeID;

  _FoodPage(this.storeID);
  CartItemsBloc cart = new CartItemsBloc();
  List<CategoryModel> category;
  List<FoodModel> list = new List();
  List<FoodModel> listNotSaleOff = new List();
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

  Future<void> getAllFood() async {
    print('storeID' + storeID);
    final myService = FoodApiService.create();
    final response = await myService.getAllFood(storeID);
    category = response.body;

    for(var cate in category){
      list += cate.foods;
    }

    if(listNotSaleOff.length == 0){
      for(var listSale in list){
        if(listSale.saleOff.saleOff == 0){
          listNotSaleOff.add(listSale);
        }
      }
    }

//    for (var listItem in list) {
//      print(listItem.name);
//    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
          future: getAllFood(),
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
        'https://www.supermarketnews.com/sites/supermarketnews.com/files/styles/article_featured_retina/public/Aldi%20store_produce%20area.jpg?itok=EIbPYvCA',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),

    );
  }
  Widget _buildBody(){
    return Column(
      children: <Widget>[
        Container(
          height: 75.0,
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Thực Phẩm Phổ Biến',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5.0),
                alignment: Alignment.center,
                child: Text(
                  '15 loại',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            ],
          ),
        ),
        for (var listFood in listNotSaleOff)
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.0,
                  color: Colors.black,
                ),
              ),
            ),
            child: ListTile(
              leading: Image.network(
                  '${listFood.image}',fit: BoxFit.cover,
                  height: 100.0,
                  width: 100.0,
                  alignment: Alignment.center),
              title: Text(
                '${utf8.decode(latin1.encode(listFood.name), allowMalformed: true)}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${oCcy.format(listFood.price)}đ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13.0,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                  size: 30.0,
                ),
                onPressed: (){
                  Data data = new Data('${listFood.id}','${listFood.image}', '${listFood.name}', '${listFood.price}', 1, listFood);
                  total = total + (double.parse(data.price.toString()) - (double.parse(data.price)*data.foods.saleOff.saleOff/100));
                  listCart.add(data);
                  badgeData++;
                  quantity.putIfAbsent(data.id, () => data.quantity);
                  showToast();
                },
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return FoodDetailPage(foodID: "${listFood.id}",);
                }));

              },
            ),
          ),
      ],


    );
  }

}