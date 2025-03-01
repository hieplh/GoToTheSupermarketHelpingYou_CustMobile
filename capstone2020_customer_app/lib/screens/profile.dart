import 'dart:convert';

import 'package:capstone2020customerapp/api/account_api_service.dart';
import 'package:capstone2020customerapp/models/customer_model.dart';
import 'package:capstone2020customerapp/screens/updateDeliveryAddress.dart';
import 'package:capstone2020customerapp/screens/updateInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api_url_constain.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  String image =
      'https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png';



  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  Customer cus;
  Future<void> getProfile() async {
      final myService = AccountApiService.create();
      final response = await myService.getCustomerByID(customer);
      cus = response.body;

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
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditIcon()
                                                : new Container(),
                                          ],
                                        )
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
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                            child: Text(
                                              '${utf8.decode(latin1.encode(cus.fullname))}',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 20.0,
                                              ),
                                            )
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
                                        new Flexible(
                                            child: Text(
                                              '${cus.dob}',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 20.0,
                                              ),
                                            )
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
                                        new Flexible(
                                            child: Text(
                                              '${cus.username}',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 20.0,
                                              ),
                                            )
                                        ),
                                      ],
                                    )),
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
                                              'Delivery Address',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditDeliveryIcon()
                                                : new Container(),
                                          ],
                                        )
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
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                if(cus.addresses == null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                            child: Text(
                                              'Chưa có địa chỉ',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 20.0,
                                              ),
                                            )
                                        ),
                                      ],
                                    )),
                                if(cus.addresses != null)
                                  for(var add in cus.addresses)
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          new Flexible(
                                              child: Text(
                                                '${utf8.decode(latin1.encode(add.addr1 + " "
                                                    +  add.addr2 + " "
                                                    + add.addr3 + " "
                                                    + add.addr4), allowMalformed: true)}',
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 20.0,
                                                ),
                                              )
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
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return LoginPage();
                                                }), ModalRoute.withName('/'));
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0),
                                      ),
                                      child: Text(
                                        'LogOut',
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

                                !_status
                                    ? _getActionButtons()
                                    : new Container(),
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateInfoPage()));
      },
    );
  }

  Widget _getEditDeliveryIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateAddressPage()));
      },
    );
  }

}