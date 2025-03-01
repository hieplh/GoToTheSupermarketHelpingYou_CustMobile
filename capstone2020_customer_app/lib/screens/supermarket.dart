
import 'dart:convert';

import 'package:capstone2020customerapp/api/market_api_service.dart';
import 'package:capstone2020customerapp/models/market_model.dart';
import 'package:capstone2020customerapp/screens/detailSupermarket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SupermarketPage extends StatefulWidget {
  @override
  _SupermarketPage createState() => _SupermarketPage();
}
FocusNode myFocusNode = new FocusNode();

List<Market> list;
Future<void> getAllBranchStore()async{
  final myService = MarketApiService.create();
  final response = await myService.getAllBranchMarket();
  list = response.body;
//    for(var listStore in list){
//      print(listStore.id);
//    }
}
class _SupermarketPage extends State<SupermarketPage> {
  String search;
  TextEditingController searchController = new TextEditingController();
  List<String> img = ["facebook.png", "facebook.png", "facebook.png"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
      body: FutureBuilder(
          future: getAllBranchStore(),
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
      child: Row(
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
              'Chọn Brand Siêu Thị',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'More Stores',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
          for (var list in list)
            Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: ListTile(
              leading: Image.network('${list.image}',
                fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,
                alignment: Alignment.center,),
              title: Text(
                'PROMO',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${utf8.decode(latin1.encode(list.name), allowMalformed: true)}',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 40.0,
              ),
              onTap: (){
                changeToDetail('${list.id}', '${list.image}', '${list.name}');
              },
              isThreeLine: true,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
        ],

      ),
    );
  }

  changeThePage() async {
//    final myService = ProjectApiService.create();
//    final response = await myService.getResource();
//    var post = response.body;
//    print(' ${post.toString()}');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return LoginPage();
        }), ModalRoute.withName('/'));
  }
  changeToDetail(String id, String image, String name) async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return DetailSupermarketPage(marketID: id, marketImage: image, marketName: name,);
        }));
  }

}
