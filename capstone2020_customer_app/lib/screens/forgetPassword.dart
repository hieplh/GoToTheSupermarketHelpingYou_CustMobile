import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/api/otp_api_service.dart';
import 'package:capstone2020customerapp/screens/confirmOTP.dart';
import 'package:flutter/material.dart';
import 'package:capstone2020customerapp/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_otp/flutter_otp.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}



class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  String email;
  FlutterOtp otp = FlutterOtp();
  TextEditingController phoneNumberController = new TextEditingController();


  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void showFailToast(String msg) {
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
              _buildConfirmButton(),

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


  Widget _buildConfirmButton(){
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
                  'XÁC NHẬN',
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


  changeThePage() async {
//    final myService = ProjectApiService.create();
//    final response = await myService.getResource();
//    var post = response.body;
//    print(' ${post.toString()}');

    print(phoneNumberController.text);

    final myService = OTPApiService.create();
    final response = await myService.getTicketForgetPassword(phoneNumberController.text);
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
          context, MaterialPageRoute(builder: (context) => ConfirmOTPPage(phoneNumber: phoneNumberController.text,)));
    }else{
      showFailToast("Sai số điện thoại");
    }

  }

}