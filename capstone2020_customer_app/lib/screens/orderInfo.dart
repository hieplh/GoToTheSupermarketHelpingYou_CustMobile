import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/screens/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class OrderInfoPage extends StatefulWidget {
  final List<Data> list;
  final double total;
  final String storeID;

  OrderInfoPage({Key key, @required this.list, @required this.total, @required this.storeID}) : super(key: key);

  @override
  _OrderInfoPage createState() => _OrderInfoPage(list, total, storeID);
}

class _OrderInfoPage extends State<OrderInfoPage> {
  List<Data> data;
  double total;
  String storeID;
  _OrderInfoPage(this.data, this.total, this.storeID);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
            _buildConfirmButton(),
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
              'Thông Tin Vận Chuyển',
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
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '1. Địa Chỉ Giao Hàng',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              '388/4 Huỳnh Tấn Phát, phường Bình Thuận, Quận 7, Thành Phố HCM',
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromRGBO(0, 175, 82, 1),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 30.0,
                  child: Icon(
                    Icons.add_circle,
                    color: const Color.fromRGBO(0, 175, 82, 1),
                  ),

                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Thêm Địa Chỉ Mới',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '2. Thông Tin Người Nhận',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Số Điện Thoại*',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 65.0,
            padding: EdgeInsets.only(bottom: 20.0),
            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  //labelText: 'Tìm kiếm đồ ăn...',
                  enabled: true,
                  hintText: '0123456789',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? const Color.fromRGBO(0, 175, 82, 1)
                          : Colors.grey),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorText: snapshot.error,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Họ và Tên*',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 65.0,
            padding: EdgeInsets.only(bottom: 20.0),
            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  //labelText: 'Tìm kiếm đồ ăn...',
                  enabled: true,
                  hintText: 'Phan Công Bình',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus
                          ? const Color.fromRGBO(0, 175, 82, 1)
                          : Colors.grey),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorText: snapshot.error,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '3. Thời Gian Giao Hàng',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                            top: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                            left: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                            right: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
                          ),

                        ),

                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Giao Hàng Trong Ngày',
                          style: TextStyle(
                            fontSize: 16.0,
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
                        padding: const EdgeInsets.only(bottom: 15.0),
                        margin: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Khung Giờ Giao',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        margin: const EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: RaisedButton(
                          onPressed: () {
                          },
                          textColor: Colors.white,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                          child: Icon(
                            Icons.alarm,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      margin: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'Chi Phí Giao Hàng: ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        '20,000đ',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                    ),
                  ],

                ),
              ],
            ),
          ),


          Container(
            padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              '4. Ghi Chú',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.only(bottom: 20.0),
            margin: const EdgeInsets.only(left: 20.0),
            height: 65.0,
            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: const Color.fromRGBO(0, 175, 82, 1),
                    ),
                  ),
                  errorText: snapshot.error,
                ),
              ),
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
            return PaymentPage(list: data, total: total, storeID: storeID,);
          }));
        },
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 175, 82, 1),
        child: Text(
          'Tiếp Tục',
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
      return HomePage();
    }), ModalRoute.withName('/'));
  }
}
