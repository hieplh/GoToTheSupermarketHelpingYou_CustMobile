
import 'dart:convert';

import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';

import 'package:capstone2020customerapp/screens/historyDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../api_url_constain.dart';

class HistoryPage extends StatefulWidget {

  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {

  List<History> listHistory;
  History historyDetail;

  Future<void> getAllFood() async {
    final myService1 = HistoryApiService.create();
    final response1 = await myService1.getAllHistory("${account.username}");
    print(response1.statusCode);
    listHistory = response1.body;

//    for(var list in listHistory){
//      print(list.marketName);
//    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
          future: getAllFood(),
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
              //onPressed: changeThePage,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              'Activity History',
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
    return Column(
      children: <Widget>[
        for(var listHistory in listHistory)
          Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 170.0,
          color: Colors.grey[200],
          //width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  historyDetail = listHistory;
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HistoryDetailPage(historyDetail: historyDetail,)));
                },
                child: Container(

                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10.0,left: 10.0),
                            child: Image.network(
                              'https://cdn2.iconfinder.com/data/icons/shopping-e-commerce-3/512/store-512.png',
                              fit: BoxFit.cover,
                              height: 100.0,
                              width: 100.0,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 15.0),
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(
                                        '${utf8.decode(latin1.encode(listHistory.market.name), allowMalformed: true)}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${utf8.decode(latin1.encode(listHistory.createDate), allowMalformed: true)}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    '${utf8.decode(latin1.encode(listHistory.addressDelivery), allowMalformed: true)}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                if(listHistory.status == 24)
                                  Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'Đơn hàng hoàn tất',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: const Color.fromRGBO(0, 175, 82, 1),
                                    ),
                                  ),
                                ),
                                if(listHistory.status != 24)
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Đơn hàng đã hủy',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],

                  ),
                ),
              ),

            ],
          ),
        ),

      ],

    );
  }

}