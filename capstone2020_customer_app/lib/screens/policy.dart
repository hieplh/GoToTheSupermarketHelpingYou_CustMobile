import 'dart:convert';

import 'package:flutter/material.dart';


class PolicyPage extends StatefulWidget {

  @override
  _PolicyPage createState() => _PolicyPage();
}

class _PolicyPage extends State<PolicyPage> {


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
        'Policy',
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
          child: Text(
            "1. Việc đặt và giao hàng chỉ xảy ra trong ngày\n",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
                "2. Vui lòng nhập đúng địa chỉ giao, nếu không chúng tôi sẽ không chịu trách nhiệm\n",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
                "3. Thời gian giao hàng phải ít nhất cách thời gian hiện tại 3 tiếng để shipper có đủ thời gian đi chợ và giao cho quý khách\n",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
                "4. Sau khi đặt hàng thành công, quý khách có thể hủy đơn trước khi có một shipper nào đó nhận đơn và dĩ nhiên sau khi hủy quý khách sẽ được hoàn lại tiền vô ví và đồng thời sẽ bị trừ khoản tiền hủy đơn\n",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }



}