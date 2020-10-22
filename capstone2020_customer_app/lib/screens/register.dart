import 'package:flutter/material.dart';
import 'package:capstone2020customerapp/screens/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}



class _RegisterPage extends State<RegisterPage> {
  String email;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController rePasswordController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();


  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(20, 25, 74, 1),
      body: Form(
        key: formkey,
        child: Column(
          children: <Widget>[

            _buildLogo(),
            _buildUsernameInput(),
            _buildPhoneNumberInput(),
            _buildAddressInput(),
            _buildRegisterButton(),
            _buildBackToLoginButton(),

          ],
        ),
      ),
    );
  }
  Widget _buildLogo(){
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('assets/apple-touch-icon-120x120.png'),
        ),
      ),
    );
  }
  Widget _buildUsernameInput(){
    return Expanded(
      flex: 0,
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
    return Expanded(
      flex: 0,
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
            validator: (usernameController) {
              if (usernameController.isEmpty) {
                return 'Please input an username';
              }
            },
            controller: usernameController,
            onSaved: (input) => email = input,
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
  Widget _buildAddressInput(){
    return Expanded(
      flex: 0,
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
            validator: (usernameController) {
              if (usernameController.isEmpty) {
                return 'Please input an username';
              }
            },
            controller: usernameController,
            onSaved: (input) => email = input,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.home,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Địa Chỉ',
              hintText: 'Nhập địa chỉ',
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
    return Expanded(
      flex: 0,
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
    return Expanded(
      flex: 1,
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
//    final myService = ProjectApiService.create();
//    final response = await myService.getResource();
//    var post = response.body;
//    print(' ${post.toString()}');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return LoginPage();
        }), ModalRoute.withName('/'));
  }

}