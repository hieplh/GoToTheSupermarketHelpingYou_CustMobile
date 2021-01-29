import 'dart:convert';

import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/screens/foodDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodTypePage extends StatefulWidget {
  final String image;
  final String type;
  final List<FoodModel> foods;
  final int quantityy;

  FoodTypePage({Key key, @required this.image, @required this.type, @required this.foods, @required this.quantityy}) : super(key: key);
  @override
  _FoodTypePage createState() => _FoodTypePage(image, type, foods, quantityy);
}

class _FoodTypePage extends State<FoodTypePage> {
  String image;
  String type;
  List<FoodModel> foods;
  int quantityy;
  _FoodTypePage(this.image, this.type, this.foods, this.quantityy);
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader() {
    return Container(
      height: 300.0,
      child: Image.network(
          '${image}',
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
              if(type == "Thịt Heo")
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Thịt Heo',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              if(type == "Thịt Bò")
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Thịt Bò',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              if(type == "Thịt Gà")
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Thịt Gà',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              if(type == "Cá")
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Hải Sản',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              if(type == "Rau Củ Tươi")
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Rau Củ Tươi',
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
                  '${quantityy} loại',
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
        if(foods.length == 0)
          Container(
            padding: EdgeInsets.only(top: 100.0),
            child: Text(
              'Không Còn Sản Phẩm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.grey[500],
              ),
            ),
          ),
        for(var listFood in foods)
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if(listFood.saleOff.saleOff != 0)
                    Container(
                    child: Text(
                      'Giá gốc: ${oCcy.format(listFood.price)}đ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ),
                  if(listFood.saleOff.saleOff != 0)
                    Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      '${oCcy.format(listFood.price - (listFood.price*listFood.saleOff.saleOff/100))}đ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if(listFood.saleOff.saleOff == 0)
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '${oCcy.format(listFood.price)}đ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                ],

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
                  if(listCart.length == 0){
                    listCart.add(data);
                    badgeData++;
                  }else{
                    for(int i = 0; i < listCart.length; i++){
                      if(listFood.id == listCart[i].id){
                        count = i;
                        print(count);
                        break;
                      }else{
                        if(listFood.id != listCart[i].id){
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
                },
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return FoodDetailPage(foodID: listFood.id,);
                }));
              },
            ),
          ),
      ],


    );
  }

}