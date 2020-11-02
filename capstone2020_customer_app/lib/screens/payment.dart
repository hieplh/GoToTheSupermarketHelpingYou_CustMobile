import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/paypal/makePayment.dart';
import 'package:capstone2020customerapp/paypal/paypalPayment.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'invoiceSumary.dart';
import 'orderInfo.dart';

class PaymentPage extends StatefulWidget {
  final List<Data> list;
  final double total;
  final String storeID;
  final String timePicked;
  PaymentPage({Key key, @required this.list, @required this.total, @required this.storeID, @required this.timePicked}) : super(key: key);
  @override
  _PaymentPage createState() => _PaymentPage(list, total, storeID, timePicked);
}

class _PaymentPage extends State<PaymentPage> {
  List<Data> data;
  double total;
  String storeID;
  String timePicked;
  _PaymentPage(this.data, this.total, this.storeID, this.timePicked);
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
            if(money >= total)
              _buildConfirmButton(),
            if(money < total)
              _buildPaymentButton(),
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

  Widget _buildBody(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 5.0, top: 15.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.assignment,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    size: 30.0,
                  ),
                ),
                Container(
                  child: Text(
                    'Thông Tin Người Nhận',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0),
            child: Text(
              '${fullName}',
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromRGBO(0, 175, 82, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Địa Chỉ: ${deliveryAddr}',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Số Điện Thoại: ${phoneNumber}',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 30.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Thời Gian Dự Kiến Giao:\n ${timePicked}, ${date.year.toString() + "-" + date.month.toString() + "-" + date.day.toString()} - Giao Hàng Trong Ngày',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 30.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Note:\n ${note}',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(bottom: 5.0, top: 15.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.payment,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    size: 30.0,
                  ),
                ),
                Container(
                  child: Text(
                    'Phương Thức Thanh Toán',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.black),
              ),
            ),
            margin: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: <Widget>[
//                Container(
//                  width: 30.0,
//                  height: 30.0,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(50.0),
//                    border: Border(
//                      bottom: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                      top: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                      left: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                      right: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                    ),
//                  ),
//                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    size: 30.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Số dư tài khoản: ${money.toString().replaceAll(regex, "")}đ',
                    style: TextStyle(
                      fontSize: 16.0,
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

  Widget _buildConfirmButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 70.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return InvoiceSumaryPage(list: data, total: total, storeID: storeID, timePicked: timePicked,);
          }));
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
        child: Text(
          'Xác Nhận Thanh Toán',
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

  Widget _buildPaymentButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 70.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PaypalPayment(
                onFinish: (number) async {

                  // payment done
                  print('order id: '+number);

                },
              ),
            ),
          );
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
        child: Text(
          'Paypal',
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
          return OrderInfoPage();
        }), ModalRoute.withName('/'));
  }
}