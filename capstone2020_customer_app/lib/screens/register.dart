import 'dart:convert';

import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/screens/confirmOTPRegister.dart';
import 'package:flutter/material.dart';
import 'package:capstone2020customerapp/screens/login.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../api_url_constain.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}



class _RegisterPage extends State<RegisterPage> {
  String email;

  TextEditingController fullnameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController rePasswordController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();

  FlutterOtp otp = FlutterOtp();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void showFailToast(String msg) {
    //setState(() {
    Fluttertoast.showToast(
        msg: "OTP: " + msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void showFailInput(String msg) {
    //setState(() {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void showSuccessToast(String msg) {
    //setState(() {
    Fluttertoast.showToast(
        msg: msg,
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
      //backgroundColor: const Color.fromRGBO(20, 25, 74, 1),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              _buildLogo(),
              _buildPhoneNumberInput(),
              _buildPasswordInput(),
              _buildRePasswordInput(),
              _buildUsernameInput(),
              _buildDoBInput(),
              _buildRegisterButton(),
              _buildBackToLoginButton(),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildLogo(){
    return Container(
      child: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('assets/apple-touch-icon-120x120.png'),
        ),
      ),
    );
  }

  Widget _buildUsernameInput(){
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder<String>(
          //stream: bloc.email,
          builder: (context, snapshot) => TextFormField(
            //onChanged: bloc.emailChanged,
            style: TextStyle(
              color: Colors.black,
            ),
            controller: fullnameController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person_pin,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Họ và Tên',
              hintText: 'Nhập họ và tên',
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
                  color: const Color.fromRGBO(0, 141, 177, 1),
                ),
              ),
              labelStyle: TextStyle(
                  color:
                  myFocusNode.hasFocus ? const Color.fromRGBO(0, 141, 177, 1) : Colors.black),
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              errorText: snapshot.error,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPhoneNumberInput(){
    return Container(
      child: Container(
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
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone_android,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Số Điện Thoại',
              hintText: 'Nhập số điện thoại',
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
                  color: const Color.fromRGBO(0, 255, 0, 1),
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
    );
  }
  Widget _buildDoBInput(){
    return Container(
      child: Container(
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
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.date_range,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Date of Birth',
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
                  color: const Color.fromRGBO(0, 255, 0, 1),
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
    );
  }
  Widget _buildPasswordInput(){
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder<String>(
          //stream: bloc.email,
          builder: (context, snapshot) => TextFormField(
            //onChanged: bloc.emailChanged,
            style: TextStyle(
              color: Colors.black,
            ),
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Password',
              hintText: 'Password',
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
                  color: const Color.fromRGBO(0, 141, 177, 1),
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
    );
  }
  Widget _buildRePasswordInput(){
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder<String>(
          //stream: bloc.email,
          builder: (context, snapshot) => TextFormField(
            //onChanged: bloc.emailChanged,
            style: TextStyle(
              color: Colors.black,
            ),
            controller: rePasswordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Re-Password',
              hintText: 'Re-Password',
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
                  color: const Color.fromRGBO(0, 141, 177, 1),
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
    );
  }

  Widget _buildRegisterButton(){
    return Container(
      child: Container(
//        width: MediaQuery.of(context).size.width * 0.8,
//        padding: EdgeInsets.only(bottom: 10.0),
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
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                alignment: Alignment.center,
                child: Text(
                  'ĐĂNG KÍ',
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
      ),
    );
  }
  Widget _buildBackToLoginButton(){
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), ModalRoute.withName('/'));
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Đã có tài khoản?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: "Đăng nhập",
                style: TextStyle(
                  color: const Color.fromRGBO(0, 175, 82, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  changeThePage() async {

  print("${dobController.text}");
  print(passwordController.text);
  print(phoneNumberController.text);
  print(fullnameController.text);

  if(phoneNumberController.text != ""){
    if(passwordController.text != ""){
      if(rePasswordController.text != ""){
        if(fullnameController.text != ""){
          if(dobController.text != ""){
            if(passwordController.text == rePasswordController.text){
              var url = API_URL_STARTPOINT + '/account/register';
              var response = await http.post(Uri.parse(url),
                  headers: {
                    'Content-type' : 'application/json',
                    "Accept": "application/json",
                  },
                  body: json.encode({
                    "dob": dobController.text,
                    "fullname": fullnameController.text,
                    "password": passwordController.text,
                    "role": "customer",
                    "username": phoneNumberController.text
                  }));
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
              if(response.statusCode == 200){
                otp.sendOtp(
                    "902792326",
                    'OTP is: ${response.body}',
                    1000,
                    9999,
                    "+84"
                );
                //showSuccessToast(response.body);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ConfirmOTPRegisterPage(phoneNumber: phoneNumberController.text,)));
//      Navigator.of(context).pushAndRemoveUntil(
//          MaterialPageRoute(builder: (context) {
//            return LoginPage();
//          }), ModalRoute.withName('/'));
              }else{
                showFailToast(response.body.toString());
              }
            }else{
              showFailInput("Mật Khẩu nhập lại không đúng");
            }
          }else{
            showFailInput("Chưa nhập ngày tháng năm sinh");
          }
        }else{
          showFailInput("Chưa nhập họ và tên");
        }
      }else{
        showFailInput("Chưa nhập re-password");
      }
    }else{
      showFailInput("Chưa nhập password");
    }
  }else{
    showFailInput("Chưa nhập số điện thoại");
  }

  }

}