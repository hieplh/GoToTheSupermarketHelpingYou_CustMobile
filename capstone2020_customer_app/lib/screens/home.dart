import 'dart:convert';
//import 'package:badges/badges.dart';
import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/screens/food.dart';
import 'package:capstone2020customerapp/screens/foodType.dart';
import 'package:capstone2020customerapp/screens/orderInfo.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'search.dart';

class HomePage extends StatefulWidget {
  final String storeID;

  HomePage({Key key, @required this.storeID}) : super(key: key);

  @override
  _HomePage createState() => _HomePage(storeID);
}

FocusNode myFocusNode = new FocusNode();


class _HomePage extends State<HomePage> {

  String storeID;
  double total = 0;
  _HomePage(this.storeID);
  int _selectedIndex = 0;
  String search;
  TextEditingController searchController = new TextEditingController();
  List<FoodModel> list;
  List<History> listHistory;
  List<Data> listCart = new List();
  List<String> foodName = [];

  var showBadge = true;
  int badgeData = 0;

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
  void showToastDelete() {
    Fluttertoast.showToast(
        msg: 'Xóa Thành Công',
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
    list = response.body;

//    final myService1 = HistoryApiService.create();
//    final response1 = await myService1.getAllHistory();
//    listHistory = response1.body;

    for (var listItem in list) {
        foodName.add(utf8.decode(latin1.encode(listItem.name), allowMalformed: true));
      }

  }


  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: const Color.fromRGBO(0, 141, 177, 1)
      body: FutureBuilder(
          future: getAllFood(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Widget> _widgetOptions = <Widget>[
                Card(
                    child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildHomeHeader(),
                      _buildHomeBody(),
                    ],
                  ),
                )),
                Card(
                  child: Column(
                    children: <Widget>[
                      _buildActivityHeader(),
                      _buildActivityBody(),
                    ],
                  ),
                ),
                Card(
                    child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildCartHeader(),
                      _buildCartBody(),
                      _buildCartSubBody(),
                     _buildOrderButton(),
                    ],
                  ),
                )

            ),
                Card(
                  child: Column(
                    children: <Widget>[
                      _buildInfo(),
                    ],
                  ),
                ),
              ];
              return Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              );
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            title: Text('Activity'),
          ),
          BottomNavigationBarItem(
            title: Text('Cart'),
              icon: new Stack(
                children: <Widget>[
                  new Icon(Icons.shopping_cart),
                  new Positioned(
                    top: -2.0,
                    right: 0.0,
                    child: new Stack(
                      children: <Widget>[
                        new Icon(Icons.brightness_1,
                            size: 18.0, color: Colors.red),
                        new Positioned(
                          top: 1.0,
                          right: 4.0,
                          child: new Text(badgeData.toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  )
                ],
              ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('Information'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(144, 238, 144, 1),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: new Icon(
              Icons.keyboard_backspace,
              color: const Color.fromRGBO(144, 238, 144, 1),
              size: 30.0,
            ),
            onPressed: changeThePage,
          ),
        ),
        Container(
//          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.center,
          child: Text(
            '${storeID}',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(foodName),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.centerLeft,
            child: Text(
              'My Activity',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text(
              'Lịch sử',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(144, 238, 144, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: new Icon(
                Icons.keyboard_backspace,
                color: const Color.fromRGBO(144, 238, 144, 1),
                size: 30.0,
              ),
              onPressed: changeThePage,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              'Cart',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  'Phan Công Bình',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                  size: 40.0,
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.01,
              color: const Color.fromRGBO(239, 239, 239, 1),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                title: Text(
                  'Support',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                onTap: () {},
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                title: Text(
                  'My Wallet',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                onTap: () {},
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.gavel,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                title: Text(
                  'Policy',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                onTap: () {},
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.supervisor_account,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(144, 238, 144, 1),
                ),
                onTap: () {},
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(239, 239, 239, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return Column(children: <Widget>[
//      Container(
//        width: MediaQuery.of(context).size.width * 0.9,
//        padding: EdgeInsets.only(bottom: 20.0),
//        child: StreamBuilder<String>(
//          //stream: bloc.email,
//          builder: (context, snapshot) => TextFormField(
//            //onChanged: bloc.emailChanged,
//            style: TextStyle(
//              color: Colors.black,
//            ),
//            controller: searchController,
//            onSaved: (input) => search = input,
//            decoration: InputDecoration(
//              prefixIcon: Icon(
//                Icons.search,
//                color: const Color.fromRGBO(0, 255, 0, 1),
//                size: 30.0,
//              ),
//              labelText: 'Tìm kiếm đồ ăn...',
//              hintText: 'Nhập đồ ăn...',
//              focusedBorder: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(30.0),
//                borderSide: BorderSide(
//                  color: Colors.black,
//                ),
//              ),
//              enabledBorder: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(30.0),
//                borderSide: BorderSide(
//                  color: Colors.black,
//                ),
//              ),
//              border: OutlineInputBorder(
//                borderRadius: BorderRadius.circular(30.0),
//                borderSide: BorderSide(
//                  color: const Color.fromRGBO(0, 141, 177, 1),
//                ),
//              ),
//              labelStyle: TextStyle(
//                  color: myFocusNode.hasFocus
//                      ? const Color.fromRGBO(0, 141, 177, 1)
//                      : Colors.grey),
//              hintStyle: TextStyle(
//                color: Colors.grey,
//              ),
//              errorText: snapshot.error,
//            ),
//          ),
//        ),
//      ),
      Container(
        height: 300.0,
        alignment: Alignment.center,
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Big_C_Ratchadamri_%28I%29.jpg/300px-Big_C_Ratchadamri_%28I%29.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
      Container(
        child: Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Phổ Biến Nhất',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => FoodPage(storeID: storeID,)));
                },
                child: Text(
                  'Xem tất cả',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color.fromRGBO(144, 238, 144, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (var listFood in list)
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[600])),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(
                          '${listFood.image}'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      width: 100.0,
                      height: 70.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${utf8.decode(latin1.encode(listFood.name), allowMalformed: true)}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${listFood.price}',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
//                          Container(
//                            alignment: Alignment.center,
//                            child: Text(
//                              '${listFood.description}',
//                              style: TextStyle(
//                                fontSize: 13.0,
//                                color: Colors.grey,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                          ),
                        ],
                      ),
                    ),
                  ],
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
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Loại Đồ Ăn',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Xem tất cả',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color.fromRGBO(144, 238, 144, 1),
                ),
              ),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodTypePage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[600])),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(
                          'https://cdnmedia.eurofins.com/apac/media/603979/kiem-nghiem-chat-luong-thit-tuoi.jpg?width=480.5764411027569&height=500'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 60.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Thịt Heo',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '53 loại',
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
                  ],
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodTypePage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[600])),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(
                          'https://fohlabeef.vn/wp-content/uploads/2019/05/th%C4%83n-n%E1%BB%99i-b%C3%B2-%C3%BAc-Tenderloin.png'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 60.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Thịt Bò',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '42 loại',
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
                  ],
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodTypePage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[600])),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(
                          'https://vinmec-prod.s3.amazonaws.com/images/20200708_040238_836115_15639394169.max-800x800.jpg'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 60.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Cá',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '21 loại',
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
                  ],
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FoodTypePage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[600])),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(
                          'https://xachtaynhat.net/wp-content/uploads/2018/06/rau-cu-fancl-300x300.jpg'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 60.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Rau Củ Tươi',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '28 loại',
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
                  ],
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
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Khuyến Mãi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
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
              '${utf8.decode(latin1.encode(listFood.name), allowMalformed: true)}',
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
              color: Color.fromRGBO(144, 238, 144, 1),
              size: 30.0,
            ),
            onTap: (){
              Data data = new Data('${listFood.id}','${listFood.image}', '${listFood.name}', '${listFood.price}');
              total = total + double.parse(data.price);
              listCart.add(data);
              badgeData++;
              print(total);
              showToast();
            },
          ),
        ),
    ]);
  }

  Widget _buildActivityBody(){
    return Container(
//
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Hiện tại',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            //for(var listHistory in listHistory)
              Container(
              width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0) //         <--- border radius here
                  ),
                border: Border(
                  bottom: BorderSide(width: 2.0, color: const Color.fromRGBO(144, 238, 144, 1),),
                  top: BorderSide(width: 2.0, color: const Color.fromRGBO(144, 238, 144, 1),),
                  left: BorderSide(width: 2.0, color: const Color.fromRGBO(144, 238, 144, 1),),
                  right: BorderSide(width: 2.0, color: const Color.fromRGBO(144, 238, 144, 1),),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10.0,left: 10.0),
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Big_C_Ratchadamri_%28I%29.jpg/300px-Big_C_Ratchadamri_%28I%29.jpg',
                                fit: BoxFit.cover,
                                height: 100.0,
                                width: 100.0,
                                alignment: Alignment.center,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text(
                                          '${storeID}',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '22 Oct',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      '388/4 Huỳnh Tấn Phát, quận 7, phường Bình Thuận, T.P Hồ Chí Minh',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Reorder',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(144, 238, 144, 1),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartBody() {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: Column(
          children: <Widget>[
            for (var listOrder in listCart)
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      width: 150.0,
                      height: 150.0,
                      child: Image.network(
                        '${listOrder.image}',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${utf8.decode(latin1.encode(listOrder.name), allowMalformed: true)}',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${listOrder.price}\n',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Số Lượng: 1\n',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    '${listOrder.price}đ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    icon: new Icon(
                                      Icons.delete,
                                      color: const Color.fromRGBO(144, 238, 144, 1),
                                    ),
                                    onPressed: (){
                                      //listCart.removeWhere(('${listOrder.id}') => '${listOrder.id}');
                                      showToastDelete();
                                    },
                                  ),

                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

          ],
        ),
    );
  }

  Widget _buildCartSubBody() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: Column(
        children: <Widget>[
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  padding: const EdgeInsets.only(top: 15.0),
//                  width: MediaQuery.of(context).size.width * 0.25,
//                  child: Text(
//                    'Voucher\n',
//                    style: TextStyle(
//                      fontSize: 15.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.6,
//                  height: 40.0,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10.0),
//                    border: Border(
//                      bottom: BorderSide(width: 1.0, color: Colors.grey),
//                      top: BorderSide(width: 1.0, color: Colors.grey),
//                      left: BorderSide(width: 1.0, color: Colors.grey),
//                      right: BorderSide(width: 1.0, color: Colors.grey),
//                    ),
//                  ),
//                  alignment: Alignment.centerRight,
//                  child: Icon(
//                    Icons.arrow_forward_ios,
//                    color: const Color.fromRGBO(0, 141, 177, 1),
//                  ),
//                ),
//              ],
//            ),
//          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    'Giá trị đơn hàng\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '$totalđ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  padding: const EdgeInsets.only(top: 15.0),
//                  width: MediaQuery.of(context).size.width * 0.65,
//                  child: Text(
//                    'Giảm Giá\n',
//                    style: TextStyle(
//                      fontSize: 15.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.2,
//                  child: Text(
//                    '-0đ',
//                    style: TextStyle(
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  padding: const EdgeInsets.only(top: 15.0),
//                  width: MediaQuery.of(context).size.width * 0.65,
//                  child: Text(
//                    'Voucher\n',
//                    style: TextStyle(
//                      fontSize: 15.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.2,
//                  child: Text(
//                    '-0đ',
//                    style: TextStyle(
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.bold,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    'Thành tiền\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '$totalđ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(144, 238, 144, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 70.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OrderInfoPage(list: listCart, total: total, storeID: storeID,);
          }));
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(144, 238, 144, 1),
        child: Text(
          'Thanh Toán',
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

  changeThePage() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return SupermarketPage();
    }), ModalRoute.withName('/'));
  }
}
