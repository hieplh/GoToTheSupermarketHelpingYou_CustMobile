import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SupportPage extends StatefulWidget {

  @override
  _SupportPage createState() => _SupportPage();
}

class _SupportPage extends State<SupportPage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );


  }
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        'Hỗ Trợ Khách Hàng',
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget _buildBody(){
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Vui lòng liên hệ qua tổng đài 0902792326 để được tư vấn hỗ trợ',
            style: TextStyle(
              fontSize: 18.0,

            ),
          ),
        ),

      ],

    );
  }



}