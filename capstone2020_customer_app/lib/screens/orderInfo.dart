import 'dart:convert';
import 'dart:math';

import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/screens/newAddress.dart';
import 'package:capstone2020customerapp/screens/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

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
  String timePicked = "00:00:00";

  _OrderInfoPage(this.data, this.total, this.storeID);
  TextEditingController phoneController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay picked;
  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(context: context, initialTime: time);

    setState(() {
      time = picked;
      timePicked = time.hour.toString() + ":" + time.minute.toString() + ":00";
      if(17 <= int.parse(time.hour.toString()) && int.parse(time.hour.toString()) <= 20){
        deliveryFee = 50000;
      }else{
        deliveryFee = 20000;
      }
    });
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("Xác Nhận"),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );

    Widget addAddr = FlatButton(
      child: Text("Thêm địa chỉ mới"),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) {
          return  NewAddressPage(list: data, total: total, storeID: storeID,);
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Chọn địa chỉ"),
      content:Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for(var addr in address)
                CheckboxGroup(
                  labels: <String>[
                    '${addr.street + ", \n" + addr.district + ", \n" + addr.ward + ", \n" + addr.city +"\n"}',
                  ],
                  onChange: (bool isChecked, String label, int index) => print("isChecked: $isChecked   label: $label  index: $index"),
                  onSelected: (List<String> checked) => deliveryAddr = '${addr.street + ", " + addr.district + ", " + addr.ward + ", " + addr.city}',
                ),
            ],

          ),
        ),
      ),
      actions: [
        okButton,
        addAddr,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                '${deliveryAddr}',
              ),
            ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 30.0,
                  child: IconButton(
                    icon: new Icon(Icons.add_circle),
                    color: const Color.fromRGBO(0, 175, 82, 1),
                    onPressed: () {
                      showAlertDialog(context);

                    },
                  ),

                ),
                Container(

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
                  fontSize: 18.0,
                ),
                controller: phoneController,
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
                  fontSize: 18.0,
                ),
                controller: fullNameController,
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
//                      Container(
//                        width: 30.0,
//                        height: 30.0,
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(50.0),
//                          border: Border(
//                            bottom: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                            top: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                            left: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                            right: BorderSide(width: 1.0, color: const Color.fromRGBO(0, 175, 82, 1),),
//                          ),
//
//                        ),
//
//                      ),
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
                  height: 40.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        margin: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Khung Giờ Giao',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                              ),
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: Colors.black),
                                top: BorderSide(width: 2.0, color: Colors.black),
                                left: BorderSide(width: 2.0, color: Colors.black),
                                right: BorderSide(width: 2.0, color: Colors.black),
                              ),
                            ),
                            margin: const EdgeInsets.only(left: 20.0),
                            child: IconButton(
                              onPressed: () {
                                selectTime(context);
                                print(time);
                              },
                              color: const Color.fromRGBO(0, 175, 82, 1),
                              icon: Icon(
                                Icons.alarm,
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: Colors.black),
                                  top: BorderSide(width: 2.0, color: Colors.black),
                                  left: BorderSide(width: 2.0, color: Colors.black,),
                                  right: BorderSide(width: 2.0, color: Colors.black),
                                ),
                              ),
                            padding: const EdgeInsets.only(top: 10.0, bottom: 5.0, left: 15.0),
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              '$timePicked',
                              style: TextStyle(
                                fontSize: 18.0,
                                //color: const Color.fromRGBO(0, 175, 82, 1),
                              ),
                            )
                          ),
                        ],

                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Chi Phí Đi Chợ: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                      child: Text(
                        '50,000đ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                    ),
                  ],

                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      margin: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Chi Phí Giao Hàng: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: const Color.fromRGBO(0, 175, 82, 1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        '${oCcy.format(deliveryFee)}đ',
                        style: TextStyle(
                          fontSize: 18.0,
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
            margin: const EdgeInsets.only(left: 20.0),

            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: noteController,
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
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
          if(fullNameController.text != ""){
            fullName = fullNameController.text;
          }
          if(phoneController.text != ""){
            phoneNumber = phoneController.text;
          }
          note = noteController.text;

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return PaymentPage(list: data, total: total, storeID: storeID, timePicked: timePicked,);
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
