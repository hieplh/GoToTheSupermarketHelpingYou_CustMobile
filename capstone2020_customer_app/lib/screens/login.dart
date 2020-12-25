

import 'dart:convert' show json, latin1, utf8;
import 'package:capstone2020customerapp/api/account_api_service.dart';
import 'package:capstone2020customerapp/api/convert_address_api_service.dart';
import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/api/tracking_api_service.dart';
import 'package:capstone2020customerapp/models/account_model.dart';
import 'package:capstone2020customerapp/models/shipper_model.dart';
import 'package:capstone2020customerapp/models/tracking_model.dart';
import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/register.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api_url_constain.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

FocusNode myFocusNode = new FocusNode();

class _LoginPageState extends State<LoginPage> {
  String email, password;
  bool _isHidePassword = true;
  String IDSTORE;
  void showSuccessToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: 'Đăng Nhập Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void showFailToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: 'Wrong username or password!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildLogo(),
              _buildUsernameInput(),
              _buildPasswordInput(),
              _buildLoginButton(),
//              _buildTextOR(),
//              _buildText(),
//              _buildFacebookAndGoogleLoginButton(),
              _buildRegisterButton(),
            ],
        ),
      ),
    );
  }
  Widget _buildLogo(){
    return Container(

      padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.8,
        ),

    );
  }
  Widget _buildUsernameInput(){
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder<String>(
          //stream: bloc.email,
          builder: (context, snapshot) => TextFormField(
            //onChanged: bloc.emailChanged,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (usernameController) {
              if (usernameController.isEmpty) {
                return 'Please input an username';
              }
            },
            controller: usernameController,
            onSaved: (input) => email = input,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_pin,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Tài Khoản',
              hintText: 'Nhập tài khoản',
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
    );
  }
  Widget _buildPasswordInput(){
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder<String>(
          //stream: bloc.password,
          builder: (context, snapshot) => TextFormField(
            //onChanged: bloc.passwordChanged,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (input) {
              if (input.isEmpty) {
                return 'Please provide a password';
              }
            },
            controller: passwordController,

            onSaved: (input) => password = input,
            focusNode: myFocusNode,
            obscureText: _isHidePassword,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: const Color.fromRGBO(0, 175, 82, 1),
              ),
              labelText: 'Mật Khẩu',
              hintText: 'Nhập mật khẩu',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30.0),
              ),
              labelStyle: TextStyle(
                  color:
                  myFocusNode.hasFocus ? Colors.black : Colors.black),
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              errorText: snapshot.error,
              suffixIcon: GestureDetector(
                onTap: () {
                  _togglePasswordVisibility();
                },
                child: Icon(
                  _isHidePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: _isHidePassword ? const Color.fromRGBO(0, 175, 82, 1) : const Color.fromRGBO(0, 175, 82, 1),
                ),
              ),
              //isDense: true,
            ),
          ),
        ),
    );
  }
  Widget _buildLoginButton(){
    return Container(
//        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 10.0),
//        height: 60.0,
        child: StreamBuilder<bool>(
          //stream: bloc.submitCheck,
          builder: (context, snapshot) => RaisedButton(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(30.0),
//            ),
            onPressed: changeThePage,
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color.fromRGBO(0, 99, 46, 1), const Color.fromRGBO(0, 220, 103, 1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                alignment: Alignment.center,
                child: Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            color: Colors.white,
          ),
        ),
    );
  }
  Widget _buildTextOR(){
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
        height: 60.0,
        child: Text(
          '-OR-',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
  Widget _buildText(){
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
        height: 60.0,
        child: Text(
          'Sign in with',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
  Widget _buildFacebookAndGoogleLoginButton(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            //width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(bottom: 20.0),
            height: 70.0,
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent,
                        offset: Offset(0,2),
                        blurRadius: 6.0,
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/facebook.png'),
                    )
                ),

              ),
//                  color: Colors.white,
            ),
          ),
          Container(
            //width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(bottom: 20.0),
            height: 70.0,
            child: GestureDetector(
              onTap: () {
//                signInWithGoogle().whenComplete(() {
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) {
//                        return Home();
//                      },
//                    ),
//                  );
//                });
              },
              child: Container(
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent,
                        offset: Offset(0,2),
                        blurRadius: 6.0,
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/google_logo.png'),
                    )
                ),

              ),
//                  color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildRegisterButton(){
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Chưa có tài khoản?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: "Đăng Kí",
                style: TextStyle(
                  color: const Color.fromRGBO(0, 175, 82, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
    );
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getString(key) ?? null;
    print('read: $value');
    IDSTORE = value;
  }
  changeThePage() async {
  _read();
  customer = usernameController.text;
  pass = passwordController.text;
    final myService = LoginApiService.create();
    final response = await myService.postAccount({"password" : passwordController.text, "role" : "customer", "username" : usernameController.text},);
    account = response.body;
    if(response.statusCode == 200){
      showSuccessToast();
      if(IDSTORE != null){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return HomePage(storeID: IDSTORE,);
            }), ModalRoute.withName('/'));
      }else{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return SupermarketPage();
            }), ModalRoute.withName('/'));
      }
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (context) {
//            return SupermarketPage();
//          }), ModalRoute.withName('/'));

    }else{
      showFailToast();
    }



  }
  
}