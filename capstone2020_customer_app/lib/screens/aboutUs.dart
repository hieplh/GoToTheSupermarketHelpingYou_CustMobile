import 'dart:convert';

import 'package:flutter/material.dart';


class AboutUsPage extends StatefulWidget {

  @override
  _AboutUsPage createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {


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
        'About Us',
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
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Go to the Supermarket helping you',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Our Members:',
            style: TextStyle(
              fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            'Lê Hoàng Hiệp (Leader)',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            'Phan Công Bình',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            'Nguyễn Trúc Đông Phương:',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Supervisor:',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            'Mr. Kiều Trọng Khánh',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),

      ],

    );
  }



}