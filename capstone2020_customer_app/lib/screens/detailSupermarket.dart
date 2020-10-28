import 'dart:convert';

import 'package:capstone2020customerapp/api/store_api_service.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class DetailSupermarketPage extends StatefulWidget {
  final String marketID;

  DetailSupermarketPage({Key key, @required this.marketID}) : super(key: key);


  @override
  _DetailSupermarketPage createState() => _DetailSupermarketPage(marketID);
}
FocusNode myFocusNode = new FocusNode();
class _DetailSupermarketPage extends State<DetailSupermarketPage> {
  String marketID;
  _DetailSupermarketPage(this.marketID);
  String search;
  String storeID;
  TextEditingController searchController = new TextEditingController();

  List<StoreModel> list;
  Future<void> getAllStore()async{
    print(marketID);
    final myService = StoreApiService.create();
    final response = await myService.getAllStore(marketID);
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
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(bottom: 20.0),
            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: searchController,
                onSaved: (input) => search = input,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    size: 30.0,
                  ),
                  labelText: 'Tìm kiếm địa chỉ Siêu Thị',
                  hintText: 'Nhập địa chỉ siêu thị',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(0, 141, 177, 1),
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? const Color.fromRGBO(0, 141, 177, 1)
                          : Colors.black),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorText: snapshot.error,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'PROMO',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      '$marketID',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Supermarket',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Lô A, Khu dân cư Cityland, số 99, Đường Nguyễn Thị Thập, Phường Tân Phú, Quận 7, Thành phố Hồ Chí Minh.',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[900],
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 150,
                padding: EdgeInsets.only(bottom: 10.0, right: 15.0),
                child: Image.network(
                    'https://www.supermarketnews.com/sites/supermarketnews.com/files/styles/article_featured_retina/public/Aldi%20store_produce%20area.jpg?itok=EIbPYvCA',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
          for (var listStore in list)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                leading: Image.network(
                  'https://www.supermarketnews.com/sites/supermarketnews.com/files/styles/article_featured_retina/public/Aldi%20store_produce%20area.jpg?itok=EIbPYvCA',
                  fit: BoxFit.contain,
                  height: 100.0,
                  width: 100.0,
                  alignment: Alignment.center,
                ),
                    title: Text(
                      '${utf8.decode(latin1.encode(listStore.name), allowMalformed: true)}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      '${utf8.decode(latin1.encode(listStore.addr1), allowMalformed: true)}, '
                          '${utf8.decode(latin1.encode(listStore.addr2), allowMalformed: true)}, '
                          '${utf8.decode(latin1.encode(listStore.addr3), allowMalformed: true)}, '
                          '${utf8.decode(latin1.encode(listStore.addr4), allowMalformed: true)} ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey[500],
                        fontSize: 14.0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    onTap: (){
                        goToHomePage('${listStore.id}');
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
