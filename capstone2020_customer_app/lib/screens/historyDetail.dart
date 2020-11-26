
import 'dart:convert';

import 'package:capstone2020customerapp/models/history_model.dart';
import 'package:capstone2020customerapp/api/history_api_service.dart';
import 'package:capstone2020customerapp/models/order_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_url_constain.dart';

class HistoryDetailPage extends StatefulWidget {
  final History historyDetail;

  HistoryDetailPage({Key key, @required this.historyDetail}) : super(key: key);

  @override
  _HistoryDetailPage createState() => _HistoryDetailPage(historyDetail);
}

class _HistoryDetailPage extends State<HistoryDetailPage> {

  History historyDetail;

  _HistoryDetailPage(this.historyDetail);

  List<OrderDetail> listOrderHistory;

  Future<void> getAllFood() async {

//
//    print("sth: " + historyDetail.marketName);
    final myService1 = HistoryApiService.create();
    final response1 = await myService1.getHistoryDetail(historyDetail.id);
    listOrderHistory = response1.body;
//    for(var list in listOrderHistory){
//      print("sth: " + list.foodId);
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
                Icons.expand_more,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 40.0,
              ),
              //onPressed: changeThePage,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              '${historyDetail.createDate}, ${historyDetail.receiveTime}',
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
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Booking ID",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700]
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    "${historyDetail.id}",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[700]
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            //width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0,left: 10.0),
                  child: Image.network(
                    'https://www.supermarketnews.com/sites/supermarketnews.com/files/styles/article_featured_retina/public/Aldi%20store_produce%20area.jpg?itok=EIbPYvCA',
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          '${utf8.decode(latin1.encode(historyDetail.marketName), allowMalformed: true)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Delivered - Jupiter Yamaha - 72C1-79945',
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
          ),
          Container(
            color: Colors.grey[200],
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.local_convenience_store,
                        color: const Color.fromRGBO(0, 175, 82, 1),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '${utf8.decode(latin1.encode(historyDetail.marketName), allowMalformed: true)}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],

                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey[400],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${utf8.decode(latin1.encode(historyDetail.addressDelivery), allowMalformed: true)}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],

                ),

              ],

            ),

          ),
          Container(
            color: Colors.grey[200],
            height: 10.0,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    "Order Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  //height: MediaQuery.of(context).size.width ,
                  child: Column(
                    children: <Widget>[
                      for (var list in listOrderHistory)
                        Container(
                          child: ListTile(
                            leading: Text(
                              '1x',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              '${utf8.decode(latin1.encode(list.foodId), allowMalformed: true)}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                              ),
                            ),
//                          subtitle: Text(
//                            '${listFood.price}',
//                            style: TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 13.0,
//                            ),
//                          ),
                            trailing: Text(
                              '${oCcy.format(list.priceOriginal)}đ',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                    ],

                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 10.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                  child: Text(
                    'Tổng Tiền',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.credit_card,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: Text(
                        '${oCcy.format(historyDetail.totalCost)}đ',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 10.0,
          ),
          if(historyDetail.note == "")
            Container(
              width: MediaQuery.of(context).size.width ,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Không có yêu cầu gì',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Cám ơn vì đã sử dụng dịch vụ của chúng tôi!',
                      style: TextStyle(
                          fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if(historyDetail.note != "")
            Container(
              width: MediaQuery.of(context).size.width ,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Yêu cầu của khách hàng',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '${historyDetail.note}',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.height ,
          ),
        ],
      ),
    );
  }



}