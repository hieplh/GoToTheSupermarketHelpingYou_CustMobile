import 'dart:convert';

import 'package:capstone2020customerapp/api/food_api_service.dart';
import 'package:capstone2020customerapp/bloc/cart_items_bloc.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api_url_constain.dart';

class WalletPage extends StatefulWidget {

  @override
  _WalletPage createState() => _WalletPage();
}
FocusNode myFocusNode = new FocusNode();
class _WalletPage extends State<WalletPage> {
  bool _isHidePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
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
            'My Wallet',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
  Widget _buildBody(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: StreamBuilder<String>(
        //stream: bloc.password,
        builder: (context, snapshot) => TextFormField(
          //onChanged: bloc.passwordChanged,
          style: TextStyle(
            color: Colors.black,
          ),

          focusNode: FocusNode(),
          obscureText: _isHidePassword,
          autofocus: false,
          enabled: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_balance_wallet,
              color: const Color.fromRGBO(0, 175, 82, 1),
            ),
            labelText: 'Số Dư Trong Ví: ${oCcy.format(account.wallet)}đ',
            errorText: snapshot.error,
//            suffixIcon: GestureDetector(
//              onTap: () {
//                _togglePasswordVisibility();
//              },
//              child: Icon(
//                _isHidePassword
//                    ? Icons.visibility_off
//                    : Icons.visibility,
//                color: _isHidePassword ? const Color.fromRGBO(0, 175, 82, 1) : const Color.fromRGBO(0, 175, 82, 1),
//              ),
//            ),
            //isDense: true,
          ),
        ),
      ),
    );
  }



}