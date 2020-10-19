import 'package:capstone2020customerapp/api/store_api_service.dart';
import 'package:capstone2020customerapp/models/store_model.dart';
import 'package:capstone2020customerapp/screens/detailSupermarket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SupermarketPage extends StatefulWidget {
  @override
  _SupermarketPage createState() => _SupermarketPage();
}
FocusNode myFocusNode = new FocusNode();

class _SupermarketPage extends State<SupermarketPage> {
  String search;
  TextEditingController searchController = new TextEditingController();
  List<String> img = ["facebook.png", "facebook.png", "facebook.png"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
      body: Form(
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
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: new Icon(
                Icons.keyboard_backspace,
                color: const Color.fromRGBO(0, 141, 177, 1),
                size: 30.0,
              ),
              onPressed: changeThePage,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Chọn Brand Siêu Thị',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBody() {
    return Expanded(
      flex: 10,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(bottom: 20.0),
            child: StreamBuilder<String>(
              //stream: bloc.email,
              builder: (context, snapshot) => TextFormField(
                //onChanged: bloc.emailChanged,
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: searchController,
                onSaved: (input) => search = input,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color.fromRGBO(0, 141, 177, 1),
                    size: 30.0,
                  ),
                  labelText: 'Tìm kiếm Brand Siêu Thị',
                  hintText: 'Nhập Brand siêu thị',
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
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'More Stores',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
          for (int i = 0; i < 1; i++)
            Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: ListTile(
              leading: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Big_C_Ratchadamri_%28I%29.jpg/300px-Big_C_Ratchadamri_%28I%29.jpg'),
              title: Text(
                'PROMO',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                'Big C',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 40.0,
              ),
              onTap: changeToDetail,
              isThreeLine: true,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
        ],

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
  changeToDetail() async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return DetailSupermarketPage();
        }));
  }
}
