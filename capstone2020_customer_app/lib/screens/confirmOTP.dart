import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:capstone2020customerapp/api/otp_api_service.dart';
import 'package:capstone2020customerapp/screens/updatePassword.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:capstone2020customerapp/screens/login.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmOTPPage extends StatefulWidget {
  final String phoneNumber;

  ConfirmOTPPage({Key key, @required this.phoneNumber}) : super(key: key);

  @override
  _ConfirmOTPPage createState() => _ConfirmOTPPage(phoneNumber);
}



class _ConfirmOTPPage extends State<ConfirmOTPPage> {
  String phoneNumber;

  _ConfirmOTPPage(this.phoneNumber);
  String email;
  FlutterOtp otp = FlutterOtp();
  TextEditingController OTPController = new TextEditingController();

  CountDownController _controller = CountDownController();

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

  void showSuccessToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: 'Xác Nhận Mã OTP Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }

  void showSuccessToastNewOTP(String msg) {
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
              _buildOTPInput(),
              _buildCountdown(),
              _buildReload(),
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


  Widget _buildOTPInput(){
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
            controller: OTPController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.track_changes,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Mã OTP',
              hintText: 'Nhập mã OTP',
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

  Widget _buildCountdown(){
    return Center(
      child: CircularCountDownTimer(
        // Countdown duration in Seconds
        duration: 60,

        // Controller to control (i.e Pause, Resume, Restart) the Countdown
        controller: _controller,

        // Width of the Countdown Widget
        width: MediaQuery.of(context).size.width / 2,

        // Height of the Countdown Widget
        height: MediaQuery.of(context).size.height / 2,

        // Default Color for Countdown Timer
        color: Colors.white,

        // Filling Color for Countdown Timer
        fillColor: Colors.red,

        // Background Color for Countdown Widget
        backgroundColor: null,

        // Border Thickness of the Countdown Circle
        strokeWidth: 5.0,

        // Begin and end contours with a flat edge and no extension
        strokeCap: StrokeCap.butt,

        // Text Style for Countdown Text
        textStyle: TextStyle(
            fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),

        // true for reverse countdown (max to 0), false for forward countdown (0 to max)
        isReverse: true,

        // true for reverse animation, false for forward animation
        isReverseAnimation: true,

        // Optional [bool] to hide the [Text] in this widget.
        isTimerTextShown: true,

        // Function which will execute when the Countdown Ends
        onComplete: () {
          // Here, do whatever you want
        },
      ),
    );

  }

  Widget _buildReload(){
    return Center(
      child: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: IconButton(
          icon: new Icon(Icons.autorenew),
          onPressed: () async {
            final myService = OTPApiService.create();
            final response = await myService.getNewOTP(phoneNumber);
            if(response.statusCode == 200){
              otp.sendOtp(
                  "902792326",
                  'OTP is: ${response.body}',
                  1000,
                  9999,
                  "+84"
              );
              //showSuccessToastNewOTP(response.body);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ConfirmOTPPage(phoneNumber: phoneNumber,)));
            }else{
              showFailToast("Không thể tạo mới mã OTP");
            }


          },
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

    print(OTPController.text);
    print(phoneNumber);
    final myService = OTPApiService.create();
    final response = await myService.confirmOTPCodeForgetPassword(phoneNumber, OTPController.text);
    if(response.statusCode == 200){
      showSuccessToast();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UpdatePasswordPage(phoneNumber: phoneNumber,)));
    }else{
      showFailToast("Sai mã OTP");
    }

  }

}