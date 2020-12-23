import 'dart:convert';

import 'package:capstone2020customerapp/api/account_api_service.dart';
import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/models/customer_model.dart';
import 'package:capstone2020customerapp/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../api_url_constain.dart';
import 'login.dart';

class UpdateInfoPage extends StatefulWidget {

  @override
  _UpdateInfoPage createState() => _UpdateInfoPage();
}

class _UpdateInfoPage extends State<UpdateInfoPage>
    with SingleTickerProviderStateMixin {
  String image =
      'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png';



  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController middleNameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  Customer cus;
  Future<void> getProfile() async {
    final myService = AccountApiService.create();
    final response = await myService.getCustomerByID(customer);
    cus = response.body;

  }

  void showFailToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: "Update thất bại",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void showSuccessToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: 'Update Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FutureBuilder(
            future: getProfile(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          height: 250.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[

                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: new Stack(
                                    fit: StackFit.loose, children: <Widget>[
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(image),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 90.0, right: 100.0),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          new CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 25.0,
                                            child: new Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ]),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Name',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: StreamBuilder<String>(
                                            //stream: bloc.email,
                                            builder: (context, snapshot) => TextFormField(
                                              //onChanged: bloc.emailChanged,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: firstNameController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: const Color.fromRGBO(0, 175, 82, 1),
                                                  size: 30.0,
                                                ),
                                                labelText: '${utf8.decode(latin1.encode(cus.firstName))}',
                                                hintText: 'Tên',
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color:
                                                    myFocusNode.hasFocus ? Colors.black : Colors.black),
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                errorText: snapshot.error,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: StreamBuilder<String>(
                                            //stream: bloc.email,
                                            builder: (context, snapshot) => TextFormField(
                                              //onChanged: bloc.emailChanged,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: middleNameController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: const Color.fromRGBO(0, 175, 82, 1),
                                                  size: 30.0,
                                                ),
                                                labelText: '${utf8.decode(latin1.encode(cus.middleName))}',
                                                hintText: 'Tên đệm',
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color:
                                                    myFocusNode.hasFocus ? Colors.black : Colors.black),
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                errorText: snapshot.error,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: StreamBuilder<String>(
                                            //stream: bloc.email,
                                            builder: (context, snapshot) => TextFormField(
                                              //onChanged: bloc.emailChanged,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: lastNameController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: const Color.fromRGBO(0, 175, 82, 1),
                                                  size: 30.0,
                                                ),
                                                labelText: '${utf8.decode(latin1.encode(cus.lastName))}',
                                                hintText: 'Họ',
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color:
                                                    myFocusNode.hasFocus ? Colors.black : Colors.black),
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                errorText: snapshot.error,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Date of Birth',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: StreamBuilder<String>(
                                            //stream: bloc.email,
                                            builder: (context, snapshot) => TextFormField(
                                              //onChanged: bloc.emailChanged,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: dobController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.calendar_today,
                                                  color: const Color.fromRGBO(0, 175, 82, 1),
                                                  size: 30.0,
                                                ),
                                                labelText: '${cus.dob}',
                                                hintText: 'Date of Birth',
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color:
                                                    myFocusNode.hasFocus ? Colors.black : Colors.black),
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                errorText: snapshot.error,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Mobile',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.only(bottom: 20.0),
                                          child: StreamBuilder<String>(
                                            //stream: bloc.email,
                                            builder: (context, snapshot) => TextFormField(
                                              //onChanged: bloc.emailChanged,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              controller: phoneNumberController,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: const Color.fromRGBO(0, 175, 82, 1),
                                                  size: 30.0,
                                                ),
                                                labelText: '${cus.phone}',
                                                hintText: 'Số điện thoại',
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
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color:
                                                    myFocusNode.hasFocus ? Colors.black : Colors.black),
                                                hintStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                errorText: snapshot.error,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Container(
                                    height: 40.0,
                                    color: const Color.fromRGBO(
                                        239, 239, 239, 1),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 1,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        print(dobController.text);
                                        print(firstNameController.text);
                                        print(lastNameController.text);
                                        print(middleNameController.text);
                                        print(phoneNumberController.text);
                                        var url = API_URL_STARTPOINT + '/account/info';
                                        var response = await http.put(Uri.parse(url),
                                            headers: {
                                              'Content-type' : 'application/json',
                                              "Accept": "application/json",
                                            },
                                            body: json.encode({
                                              "dob" : "${dobController.text}",
                                              "firstName" : firstNameController.text,
                                              "lastName" : lastNameController.text,
                                              "middleName" : middleNameController.text,
                                              "phone" : phoneNumberController.text,
                                              "role" : "customer",
                                              "username" : cus.username
                                            }));

                                        if(response.statusCode == 200){
                                          showSuccessToast();
                                          Navigator.pop(
                                              context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                        }else{
                                          showFailToast();
                                        }

                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0),
                                      ),
                                      child: Text(
                                        'Cập Nhật Thông Tin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          letterSpacing: 2.0,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      color: const Color.fromRGBO(0, 175, 82, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
            }


        ));
  }




}