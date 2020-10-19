import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/bloc/cart_items_bloc.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';

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
  List<FoodModel> list;
  List<Data> listCart = new List();
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
    final response = await myService.getAllFood("BIGCTHAODIEN");
    list = response.body;
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
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Big_C_Ratchadamri_%28I%29.jpg/300px-Big_C_Ratchadamri_%28I%29.jpg',
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
        for (var listFood in list)
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
                '${listFood.name}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${listFood.price}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13.0,
                ),
              ),
              trailing: Icon(
                Icons.add_circle_outline,
                color: Color.fromRGBO(0, 141, 177, 1),
                size: 30.0,
              ),
              onTap: (){
//                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                  return FoodDetailPage();
//                }));
                cart.addToCart("${listFood.id}");
                print(cart.addItems);
                showToast();
              },
            ),
          ),
      ],


    );
  }

}