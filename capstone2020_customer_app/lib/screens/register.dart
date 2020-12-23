import 'package:capstone2020customerapp/api/login_api_service.dart';
import 'package:flutter/material.dart';
import 'package:capstone2020customerapp/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}



class _RegisterPage extends State<RegisterPage> {
  String email;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController middleNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController rePasswordController = new TextEditingController();
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

  void showSuccessToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: 'Đăng Kí Thành Công',
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
              _buildFirstNameInput(),
              _buildMiddleNameInput(),
              _buildLastNameInput(),
              _buildUsernameInput(),
              _buildPhoneNumberInput(),
              _buildDoBInput(),
              _buildPasswordInput(),
              _buildRePasswordInput(),
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
  Widget _buildFirstNameInput(){
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
            controller: firstNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Tên',
              hintText: 'Nhập tên',
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
  Widget _buildLastNameInput(){
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
            controller: lastNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Họ',
              hintText: 'Nhập họ',
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
  Widget _buildMiddleNameInput(){
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
            controller: middleNameController,
            onSaved: (input) => email = input,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: const Color.fromRGBO(0, 175, 82, 1),
                size: 30.0,
              ),
              labelText: 'Tên đệm',
              hintText: 'Nhập tên đệm',
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
            controller: usernameController,
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
//    final myService = ProjectApiService.create();
//    final response = await myService.getResource();
//    var post = response.body;
//    print(' ${post.toString()}');
    print(dobController.text);
  print(firstNameController.text);
  print(lastNameController.text);
  print(middleNameController.text);
  print(passwordController.text);
  print(phoneNumberController.text);
  print(usernameController.text);
    final myService = LoginApiService.create();
    final response = await myService.postAccount({
      "dob" : dobController.text,
      "firstName" : firstNameController.text,
      "lastName" : lastNameController.text,
      "middleName" : middleNameController.text,
      "password" : passwordController.text,
      "phone" : phoneNumberController.text,
      "role" : "customer",
      "username" : usernameController.text},);
    if(response.statusCode == 200){
      showSuccessToast();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return LoginPage();
          }), ModalRoute.withName('/'));
    }else{
      showFailToast(response.body.toString());
    }

  }

}