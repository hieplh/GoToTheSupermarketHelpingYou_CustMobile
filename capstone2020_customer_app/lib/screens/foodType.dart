import 'dart:convert';

import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/screens/foodDetail.dart';
import 'package:flutter/material.dart';

class FoodTypePage extends StatefulWidget {
  final String image;
  final String type;
  final List<FoodModel> foods;
  final int quantity;

  FoodTypePage({Key key, @required this.image, @required this.type, @required this.foods, @required this.quantity}) : super(key: key);
  @override
  _FoodTypePage createState() => _FoodTypePage(image, type, foods, quantity);
}

class _FoodTypePage extends State<FoodTypePage> {
  String image;
  String type;
  List<FoodModel> foods;
  int quantity;
  _FoodTypePage(this.image, this.type, this.foods, this.quantity);

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
                    'Cá',
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
                  '${quantity} loại',
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
              subtitle: Text(
                'Số Lượng: 23\n\n'
                    '${oCcy.format(listFood.price)}đ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13.0,
                ),
              ),
              trailing: Icon(
                Icons.add_circle_outline,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
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