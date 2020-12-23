import 'dart:convert';
import 'dart:math';
//import 'package:badges/badges.dart';
import 'package:capstone2020customerapp/api/convert_address_api_service.dart';
import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/api/market_detail_api_service.dart';
import 'package:capstone2020customerapp/api/order_api_service.dart';
import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/category_model.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/models/tracking_model.dart';
import 'package:capstone2020customerapp/screens/aboutUs.dart';
import 'package:capstone2020customerapp/screens/policy.dart';
import 'package:capstone2020customerapp/screens/profile.dart';
import 'package:capstone2020customerapp/screens/support.dart';
import 'package:capstone2020customerapp/screens/wallet.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:capstone2020customerapp/screens/food.dart';
import 'package:capstone2020customerapp/screens/foodType.dart';
import 'package:capstone2020customerapp/screens/history.dart';
import 'package:capstone2020customerapp/screens/orderInfo.dart';
import 'package:capstone2020customerapp/screens/progress.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'foodDetail.dart';
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

  _HomePage(this.storeID);
  int _selectedIndex = 0;
  String search;
  TextEditingController searchController = new TextEditingController();
  List<CategoryModel> category;
  List<FoodModel> list = new List();
  List<FoodModel> listNotSaleOff = new List();
  List<FoodModel> listSaleOff = new List();
  List<String> foodName = [];
  int _defaultValue = 1;
  var showBadge = true;
  int cont = 0;
  StoreModel market;

  void showToast() {
    //setState(() {
      Fluttertoast.showToast(
          msg: 'Thêm Thành Công',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
          textColor: Colors.white
      );
    //});
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
  var myOrder;
  StoreModel marketPlace;
  Tracking convertDestLatLng;
  Tracking convertSourceLatLng;
  Future<void> getAllFood() async {
    idStore = storeID;
    print('storeID' + storeID);
    final myService = FoodApiService.create();
    final response = await myService.getAllFood(storeID);
    category = response.body;

    if(list.length == 0){
      for(var cate in category){
        list += cate.foods;
      }
    }

    if(listSaleOff.length == 0){
      if(listNotSaleOff.length == 0){
        for(var listSale in list){
          if(listSale.saleOff.saleOff != 0){
            listSaleOff.add(listSale);
          }else{
            listNotSaleOff.add(listSale);
          }
        }
      }
    }


    if(listExample.length == 0){
      for (var listFood in list) {
        listExample.add(utf8.decode(latin1.encode(listFood.name), allowMalformed: true));
        //listExample.add(listFood.id);
      }
    }

    if(beef.length == 0){
      if(chicken.length == 0){
        if(pig.length == 0){
          if(fish.length == 0){
            if(vegetable.length == 0){
              for(var cate in category){
                if(cate.id == "THITBO"){
                  beef += cate.foods;
                }else if(cate.id == "THITGA"){
                  chicken += cate.foods;
                }else if(cate.id == "THITHEO"){
                  pig += cate.foods;
                }else if(cate.id == "CA"){
                  fish += cate.foods;
                }else{
                  vegetable += cate.foods;
                }
              }
            }
          }
        }
      }
    }



    final myService2 = LoginApiService.create();
    final response2 = await myService2.postAccount({"password" : pass, "role" : "customer", "username" : customer},);
    account = response2.body;

    if(account.addresses == null){
      deliveryAddr = "";
    }else{
      for(var addr in account.addresses){
        deliveryAddr = utf8.decode(latin1.encode(addr.addr1 + " " +  addr.addr2 + " " + addr.addr3 + " " + addr.addr4), allowMalformed: true);
      }
    }


    final myService3 = MarketDetailApiService.create();
    final response3 = await myService3.getStoreByID(storeID);
    market = response3.body;

    //print(response1.body.id);

//    for (var listItem in list) {
//        foodName.add(utf8.decode(latin1.encode(listItem.name), allowMalformed: true));
//      }
    if(listCart.length == 0){
      print(total);
      total = 0;
    }

    if(ID != null){
      final myService1 = OrderApiService.create();
      myOrder = await myService1.getOrderByID(ID);

      print("ID: " + ID);

      final myService2 = ConvertAddressApiService.create();
      var response2 = await myService2.getLatLng("${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}");
      convertDestLatLng = response2.body;
//      final query = "${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}";
//      var addresses = await Geocoder.local.findAddressesFromQuery(query);
//      var first = addresses.first;

      DEST_LOCATION = LatLng(double.parse(convertDestLatLng.lat), double.parse(convertDestLatLng.lng));
      print("dest location : ${DEST_LOCATION}");
//      print("${first.featureName} : ${first.coordinates}");
      final query1 = "${utf8.decode(latin1.encode(market.addr1), allowMalformed: true)}" + " "
          + "${utf8.decode(latin1.encode(market.addr2), allowMalformed: true)}" + " "
          + "${utf8.decode(latin1.encode(market.addr3), allowMalformed: true)}" + " "
          + "${utf8.decode(latin1.encode(market.addr4), allowMalformed: true)}";
      print(query1);
      final myService4 = ConvertAddressApiService.create();
      final response4 = await myService4.getLatLng(query1);
      print(response4.statusCode);
      convertSourceLatLng = response4.body;

//      var addresses1 = await Geocoder.local.findAddressesFromQuery(query1);
//      var first1 = addresses1.first;

      SOURCE_LOCATION = LatLng(double.parse(convertSourceLatLng.lat), double.parse(convertSourceLatLng.lng));
      print("source location : ${SOURCE_LOCATION}");
//      print("${first1.featureName} : ${first1.coordinates}");
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
//     backgroundColor: Colors.white,
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
                      child: Container(
                        //height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            if(listCart.length != 0)
                              _buildCartHeader(),
                            if(listCart.length != 0)
                              _buildCartBody(),
                            if(listCart.length != 0)
                              _buildCartSubBody(),
                            if(listCart.length != 0)
                              _buildOrderButton(),
                            if(listCart.length == 0)
                              _buildEmpty(),
                          ],
                        ),
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
            title: Text('Trang Chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            title: Text('Hoạt Động'),
          ),
          BottomNavigationBarItem(
            title: Text('Giỏ Hàng'),
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
            title: Text('Tài Khoản'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(0, 175, 82, 1),
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
              color: const Color.fromRGBO(0, 175, 82, 1),
              size: 30.0,
            ),
            onPressed: changeThePage,
          ),
        ),
        Container(
//          width: MediaQuery.of(context).size.width * 0.7,
          alignment: Alignment.center,
          child: Text(
            '${utf8.decode(latin1.encode(market.name), allowMalformed: true)}',
            style: TextStyle(
              fontSize: 17.0,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(

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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HistoryPage()));
              },
              child: Text(
                'Lịch sử',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
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
                color: const Color.fromRGBO(0, 175, 82, 1),
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
                  backgroundImage: NetworkImage("https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
                ),
                title: Text(
                  '${utf8.decode(latin1.encode(account.lastName)) + " " + utf8.decode(latin1.encode(account.middleName)) + " " + utf8.decode(latin1.encode(account.firstName))}',
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
                  color: const Color.fromRGBO(0, 175, 82, 1),
                  size: 40.0,
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                title: Text(
                  'Support',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SupportPage()));
                },
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
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                title: Text(
                  'My Wallet',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return WalletPage();
                  }));
                },
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
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                title: Text(
                  'Policy',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => PolicyPage()));
                },
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
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: const Color.fromRGBO(0, 175, 82, 1),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
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
      Container(
        height: 300.0,
        alignment: Alignment.center,
        child: Image.network(
          '${market.image}',
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
                    color: const Color.fromRGBO(0, 175, 82, 1),
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
            for (var listFood in listNotSaleOff)
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return FoodDetailPage(foodID: "${listFood.id}",);
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
                            '${listFood.image}'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                        width: 100.0,
                        height: 70.0,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              height: 40.0,
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
                              width: 100.0,
                              height: 20.0,
                              alignment: Alignment.center,
                              child: Text(
                                '${oCcy.format(listFood.price)}đ',
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
//            Container(
//              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//              child: Text(
//                'Xem tất cả',
//                style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 16.0,
//                  color: const Color.fromRGBO(0, 175, 82, 1),
//                ),
//              ),
//            ),
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
                  return FoodTypePage(image: 'https://cdnmedia.eurofins.com/apac/media/603979/kiem-nghiem-chat-luong-thit-tuoi.jpg?width=480.5764411027569&height=500', type: 'Thịt Heo', foods: pig, quantityy: pig.length,);
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
                              '${pig.length} loại',
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
                  return FoodTypePage(image: 'https://fohlabeef.vn/wp-content/uploads/2019/05/th%C4%83n-n%E1%BB%99i-b%C3%B2-%C3%BAc-Tenderloin.png', type: 'Thịt Bò', foods: beef, quantityy: beef.length,);
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
                              '${beef.length} loại',
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
                  return FoodTypePage(image: 'https://www.thespruceeats.com/thmb/u91gwhnYG4kP40OkswDDM1VQjQA=/3648x3648/smart/filters:no_upscale()/roasted-chicken-legs-521968290-5888fd773df78caebc737427.jpg', type: 'Thịt Gà', foods: chicken, quantityy: chicken.length,);
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
                          'https://www.thespruceeats.com/thmb/u91gwhnYG4kP40OkswDDM1VQjQA=/3648x3648/smart/filters:no_upscale()/roasted-chicken-legs-521968290-5888fd773df78caebc737427.jpg'),
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
                              'Thịt Gà',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${chicken.length} loại',
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
                  return FoodTypePage(image: 'https://vinmec-prod.s3.amazonaws.com/images/20200708_040238_836115_15639394169.max-800x800.jpg', type: 'Cá', foods: fish, quantityy: fish.length,);
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
                              '${fish.length} loại',
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
                  return FoodTypePage(image: 'https://xachtaynhat.net/wp-content/uploads/2018/06/rau-cu-fancl-300x300.jpg', type: 'Rau Củ Tươi', foods: vegetable, quantityy: vegetable.length,);
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
                              '${vegetable.length} loại',
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
      for (var listFood in listSaleOff)
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
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
//              if(listCart.length == 0){
                listCart.add(data);
                badgeData++;
//              }else{
//                for(int i = 0; i < listCart.length; i++){
//                  if(listFood.id != listCart[i].id && cont == 0){
//                    listCart.add(data);
//                    badgeData++;
//                    cont = 1;
//                    break;
//                  }else{
//                    cont = 0;
//                    if(cont == 0 && listFood.id == listCart[i].id){
//                      listCart[i].quantity++;
//                      break;
//                    }
//                  }
//                }
//              }

                quantity.putIfAbsent(data.id, () => data.quantity);
                print(quantity);
                print(total);
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
            if(myOrder != null)
              GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ProgressPage(storeID: storeID,)));
              },
                child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //         <--- border radius here
                    ),
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                    top: BorderSide(width: 2.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                    left: BorderSide(width: 2.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                    right: BorderSide(width: 2.0, color: const Color.fromRGBO(0, 175, 82, 1),),
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
                                  '${market.image}',
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
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          child: Text(
                                            '${utf8.decode(latin1.encode(market.name), allowMalformed: true)}',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        'Thời gian giao: ${myOrder.body.timeDelivery}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Text(
                                        '${utf8.decode(latin1.encode(myOrder.body.addressDelivery), allowMalformed: true)}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[700],
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
                              'Processing...',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0, 175, 82, 1),
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
                      padding: const EdgeInsets.only(top: 15.0),
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
                          if(listOrder.foods.saleOff.saleOff != 0)
                            Container(
                              child: Text(
                                'Giá gốc: ${oCcy.format(double.parse(listOrder.price))}đ\n',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                            ),
                          if(listOrder.foods.saleOff.saleOff == 0)
                            Container(
                              child: Text(
                                '${oCcy.format(double.parse(listOrder.price))}đ\n',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Số Lượng:\n',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: FloatingActionButton(
                                          heroTag: null,
                                          onPressed: () {
                                            setState(() {
                                              for(var data in listCart){
                                                if(utf8.decode(latin1.encode(listOrder.name), allowMalformed: true) == utf8.decode(latin1.encode(data.name), allowMalformed: true)){
                                                  quantity.update(data.id, (value) => (quantity[data.id] - 1));
                                                  if(quantity[data.id] < data.quantity){
                                                    total = total - double.parse(data.price.toString());
                                                  }
                                                  data.quantity = quantity[data.id];
                                                }
                                              }
                                            });
                                          },
                                          child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.white),
                                          backgroundColor: const Color.fromRGBO(0, 175, 82, 1)),
                                    ),
                                    Text(
                                      '${listOrder.quantity}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: FloatingActionButton(
                                        heroTag: null,
                                        child: Icon(Icons.add, color: Colors.white),
                                        backgroundColor: const Color.fromRGBO(0, 175, 82, 1),
                                        onPressed: () {
                                          setState(() {
                                            for(var data in listCart){
                                              if(utf8.decode(latin1.encode(listOrder.name), allowMalformed: true) == utf8.decode(latin1.encode(data.name), allowMalformed: true)){
                                                quantity.update(data.id, (value) => (quantity[data.id] + 1));
                                                if(quantity[data.id] > data.quantity ){
                                                  total = total + double.parse(data.price.toString());
                                                }
                                                data.quantity = quantity[data.id];

                                              }
                                            }

                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],

                          ),

                          Container(
                            child: Row(
                              children: <Widget>[
                                if(listOrder.foods.saleOff.saleOff == 0)
                                  Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    '${oCcy.format((double.parse(listOrder.price) * listOrder.quantity))}đ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if(listOrder.foods.saleOff.saleOff != 0)
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      '${oCcy.format(((double.parse(listOrder.price) - (double.parse(listOrder.price)*listOrder.foods.saleOff.saleOff/100)) * listOrder.quantity))}đ',
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
                                      color: const Color.fromRGBO(0, 175, 82, 1),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        badgeData--;
                                        listCart.removeWhere((element) => element == listOrder);
                                        total = total - double.parse(listOrder.price.toString())*listOrder.quantity;
                                      });
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
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    'Giá trị đơn hàng\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    '${oCcy.format(total)}đ',
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
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    'Thành tiền\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    '${oCcy.format(total)}đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 175, 82, 1),
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
          if(listCart.length <= 5){
            shoppingFee = 80000;
          }else if(5 < listCart.length && listCart.length <= 10){
            shoppingFee = 100000;
          }else if(shoppingFee > 10){
            shoppingFee = 120000;
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return OrderInfoPage(list: listCart, total: total, storeID: storeID,);
          }));
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
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

  Widget _buildEmpty(){
    return Container(
      child: Text(
        "Không có gì trong giỏ hàng",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600]
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
