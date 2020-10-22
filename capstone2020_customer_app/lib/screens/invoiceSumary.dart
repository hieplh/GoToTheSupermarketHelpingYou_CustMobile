import 'dart:convert';

import 'package:capstone2020customerapp/api/order_api_service.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class InvoiceSumaryPage extends StatefulWidget {
  final List<Data> list;
  final double total;
  final String storeID;
  InvoiceSumaryPage({Key key, @required this.list, @required this.total, @required this.storeID}) : super(key: key);
  @override
  _InvoiceSumaryPage createState() => _InvoiceSumaryPage(list, total, storeID);
}

class _InvoiceSumaryPage extends State<InvoiceSumaryPage> {
  List<Data> data;
  double total;
  String storeID;
  _InvoiceSumaryPage(this.data, this.total, this.storeID);
  void showToast() {
    Fluttertoast.showToast(
        msg: 'Đặt Hàng Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: const Color.fromRGBO(0, 175, 82, 1),
        textColor: Colors.white
    );
//    Navigator.of(context).pushAndRemoveUntil(
//        MaterialPageRoute(builder: (context) {
//          return HomePage();
//        }), ModalRoute.withName('/'));
  }

  Future<void> postOrder()async{
//    List<OrderDetail> details = List<OrderDetail>();
//    OrderDetail detail = new OrderDetail("BONGCAIXANH", 23900, 0, 0, 1);
//    details.add(detail);
//    TimeTravel timeTravel = new TimeTravel("00:00:00", "00:00:00", "00:00:00", "00:00:00");
//    final myService = OrderApiService.create();
//    final respone = await myService.postOrder(20, 50, "123456", "2020-10-14", details, "BIGCTHAODIEN", "abcde", "18:30:00", timeTravel, 23900);
//    print(respone.body.toString());
    var url = 'http://10.1.133.199:1234/smhu/api/order';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type' : 'application/json',
          "Accept": "application/json",
        },
        body: json.encode({
          "costDelivery": '20000',
          "costShopping": '50000',
          "cust": "123456",
          "dateDelivery": "2020-10-20",
          "details": [
            for(var list in data)
            {
              "food": "${list.id}",
              "priceOriginal": '${list.price}',
              "pricePaid": '0',
              "saleOff": '0',
              "weight": '1'
            }
          ],
          "lat": "string",
          "lng": "string",
          "market": storeID,
          "note": "abcde",
          "timeDelivery": "18:30:00",
          "timeTravel": {
            "delivery": "00:30:00",
            "going": "00:15:00",
            "shopping": "01:15:00",
            "traffic": "00:30:00"
          },
          "totalCost": '${total + 20000 + 50000}'
        }));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    showToast();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print(response.statusCode);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return HomePage(storeID: storeID,);
          }), ModalRoute.withName('/'));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("false");
      throw Exception('Fail ');
    }
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
            _buildSubBody(),
            _buildOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
              'Xác Nhận Thanh Toán',
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

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          for (var list in data)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(15.0),
                    height: 150.0,
                    child: Image.network(
                      '${list.image}',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '${utf8.decode(latin1.encode(list.name), allowMalformed: true)}',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${list.price}\n',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),

                        ),
                        Container(
                          child: Text(
                            'Số Lượng: x1\n',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Container(
                                child: Text(
                                  '${list.price}đ',
                                  style: TextStyle(
                                    fontSize: 18.0,
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
        ],
      ),
    );
  }
  Widget _buildSubBody() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Tổng giá trị đơn hàng\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '${total}đ',
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
//                  width: MediaQuery.of(context).size.width * 0.6,
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
//                  width: MediaQuery.of(context).size.width * 0.6,
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
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Phí vận chuyển\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '20,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Phí đi chợ\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '50,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Tổng cộng(VAT)\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '${total + 20000 + 50000}đ',
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
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 70.0,
      child: RaisedButton(
        onPressed: (){
          postOrder();
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
        child: Text(
          'Đặt Hàng',
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
          return PaymentPage();
        }), ModalRoute.withName('/'));
  }
}