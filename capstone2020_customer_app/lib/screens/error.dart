import 'dart:convert';

import 'package:capstone2020customerapp/api/store_api_service.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPage createState() => _ErrorPage();
}
FocusNode myFocusNode = new FocusNode();
class _ErrorPage extends State<ErrorPage> {
  String search;
  String storeID;
  TextEditingController searchController = new TextEditingController();
  List<String> img = ["facebook.png", "facebook.png", "facebook.png"];

  List<StoreModel> list;
  Future<void> getAllStore()async{
    final myService = StoreApiService.create();
    final response = await myService.getAllStore();
    String body = utf8.decode(response.bodyBytes);
    list = response.body;
//    for(var listStore in list){
//      print(utf8.decode(latin1.encode(listStore.name), allowMalformed: true));
//    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
      body: FutureBuilder(
          future: getAllStore(),
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
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: new Icon(
              Icons.keyboard_backspace,
              color: const Color.fromRGBO(0, 175, 82, 1),
              size: 30.0,
            ),
            onPressed: changeThePage,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Chọn Địa Chỉ Siêu Thị',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            'Chưa Có Chi Nhánh Siêu Thị'
          ),
        ),
      ],
    );
  }

  changeThePage() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return SupermarketPage();
        }), ModalRoute.withName('/'));
  }

  goToHomePage(String storeID) async {
    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => HomePage(storeID: storeID)));
  }
}
