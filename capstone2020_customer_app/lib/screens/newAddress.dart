import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/address.dart';
import 'package:capstone2020customerapp/screens/orderInfo.dart';
import 'package:flutter/material.dart';

import 'home.dart';
class NewAddressPage extends StatefulWidget {
  final List<Data> list;
  final double total;
  final String storeID;

  NewAddressPage({Key key, @required this.list, @required this.total, @required this.storeID}) : super(key: key);
  @override
  _NewAddressPage createState() => _NewAddressPage(list, total, storeID);
}

class _NewAddressPage extends State<NewAddressPage> {
  List<Data> data;
  double total;
  String storeID;
  _NewAddressPage(this.data, this.total, this.storeID);

  int _value;
  int _valueWard;
  int _valueStreet;
  String dist;
  String districtName;
  String wardName;
  String street;
  String streetName;
  List district = ["Quận 1", "Quận 2", "Quận 3", "Quận 4", "Quận 5", "Quận 6",
    "Quận 7", "Quận 8","Quận 9", "Quận 10", "Quận 11", "Quận 12", "Quận Bình Tân", "Quận Bình Thạnh",
    "Quận Gò Vấp", "Quận Phú Nhuận", "Quận Tân Bình", "Quận Tân Phú", "Quận Thủ Đức",];

  List ward_1 = ["Phường Bến Nghé", "Phường Bến Thành", "Phường Cầu Kho", "Phường Ông Lãnh", "Phường Cô Giang",
    "Phường Nguyễn Cư Trinh", "Phường Nguyễn Thái Bình", "Phường Phạm Ngũ Lão", "Phường Tân Định", "Phường Đa Kao"];

  List street_1 = ["Alexandre de Rhodes" , "Bà lê Chân", "Bến Chương Dương", "Bùi Thị Xuân", "Bùi Viện", "Cách Mạnh Thánh 8",
   "Calmette", "Cao Bá Nhạ", "Cáo Bá Quát", "Cây Điệp", "Chu Mạnh Chinh", "Cô Bắc", "Cô Giang "];

  List ward_2 = ["Phường An Khánh", "Phường An Lợi Đông", "Phường An Phú", "Phường Bình An", "Phường Bình Khánh",
    "Phường Bình Trưng Tây", "Phường Bình Trưng Đông", "Phường Cát Lái", "Phường Thạnh Mỹ Lợi", "Phường Thảo Điền", "Phường Thủ Thiêm"];

  List street_2 = ["An Phú" , "An Phú - An Khánh", "Đại lộ Đông Tây", " Đặng Hữu Đông", " Đường D2", "Võ Trường Toản",
    "Trần Não", "Thảo Điền", "Mai Chí Thọ", "Đường số 22", "Nguyễn Tư Nghiêm", "Nguyễn Văn Cừ", "Đặng Hữu Đông"];

  TextEditingController streetController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Text(
        'Địa chỉ mới',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(){
    return Container(
      child: Column(
        children: <Widget>[
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.4,
//                  padding: EdgeInsets.only(left: 10.0, bottom: 15.0),
//                  child: Text(
//                    'Họ và tên',
//                    style: TextStyle(
//                      fontSize: 20.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.6,
//                  padding: EdgeInsets.only(bottom: 15.0),
//                  child: Text(
//                    'Phan Công Bình',
//                    style: TextStyle(
//                      fontSize: 20.0,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.4,
//                  padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
//                  child: Text(
//                    'Số điện thoại',
//                    style: TextStyle(
//                      fontSize: 20.0,
//                    ),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width * 0.6,
//                  padding: EdgeInsets.only(bottom: 10.0),
//                  child: Text(
//                    '0123456789',
//                    style: TextStyle(
//                      fontSize: 20.0,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Thành phố',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 65.0,
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: StreamBuilder<String>(
                    //stream: bloc.email,
                    builder: (context, snapshot) => TextFormField(
                      //onChanged: bloc.emailChanged,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        //labelText: 'Tìm kiếm đồ ăn...',
                        enabled: true,
                        hintText: 'Hồ Chí Minh',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(0, 175, 82, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Quận/Huyện',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(left: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45.0,
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0) //         <--- border radius here
                    ),
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black,),
                      top: BorderSide(width: 1.0, color: Colors.black,),
                      left: BorderSide(width: 1.0, color: Colors.black,),
                      right: BorderSide(width: 1.0, color: Colors.black,),
                    ),
                  ),
                  child: DropdownButton(
                    value: _value,
                    items: [
                      for(int i = 0; i < district.length; i++)
                        DropdownMenuItem(
                          child: Text(district[i].toString()),
                          value: i + 1,
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        districtName = district[value - 1];
                        dist = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Phường/Xã',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(left: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45.0,
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0) //         <--- border radius here
                    ),
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black,),
                      top: BorderSide(width: 1.0, color: Colors.black,),
                      left: BorderSide(width: 1.0, color: Colors.black,),
                      right: BorderSide(width: 1.0, color: Colors.black,),
                    ),
                  ),
                  child: DropdownButton(
                    value: _valueWard,
                    items: [
                      if(dist == "1")
                        for(int i = 0; i < ward_1.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_1[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "2")
                        for(int i = 0; i < ward_2.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_2[i].toString()),
                            value: i + 1,
                          ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _valueWard = value;
                        if(dist == "1"){
                          wardName = ward_1[value - 1];
                        }
                        if(dist == "2"){
                          wardName = ward_2[value - 1];
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Đường',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(left: 20.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 45.0,
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0) //         <--- border radius here
                    ),
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black,),
                      top: BorderSide(width: 1.0, color: Colors.black,),
                      left: BorderSide(width: 1.0, color: Colors.black,),
                      right: BorderSide(width: 1.0, color: Colors.black,),
                    ),
                  ),
                  child: DropdownButton(
                    value: _valueStreet,
                    items: [
                      if(dist == "1")
                        for(int i = 0; i < street_1.length; i++)
                          DropdownMenuItem(
                            child: Text(street_1[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "2")
                        for(int i = 0; i < street_2.length; i++)
                          DropdownMenuItem(
                            child: Text(street_2[i].toString()),
                            value: i + 1,
                          ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _valueStreet = value;
                        if(dist == "1"){
                          streetName = street_1[value - 1];
                        }
                        if(dist == "2"){
                          streetName = street_2[value - 1];
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Số Nhà',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin: const EdgeInsets.only(left: 20.0),
                  padding: EdgeInsets.only(top: 10.0),
                  child: StreamBuilder<String>(
                    //stream: bloc.email,
                    builder: (context, snapshot) => TextFormField(
                      //onChanged: bloc.emailChanged,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: streetController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(vertical: 20.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: const Color.fromRGBO(0, 175, 82, 1),
                          ),
                        ),
                        errorText: snapshot.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(){
      return Expanded(
        flex: 0,
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60.0,
                  alignment: Alignment.center,
                  child: Text(
                    'Thêm địa chỉ',
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
    Address addr = new Address("Phan Công Bình", "0123456789", "Hồ Chí Minh", districtName, wardName, streetController.text + " " + streetName);
    address.add(addr);
    //deliveryAddr = streetController.text + ", " + districtName + ", " + wardName + ", " + "Hồ Chí Minh";
    //print(streetController.text);
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) {
      return OrderInfoPage(list: data, total: total, storeID: storeID,);
    }));
//    Navigator.of(context).pushAndRemoveUntil(
//        MaterialPageRoute(builder: (context) {
//          return OrderInfoPage();
//        }), ModalRoute.withName("/OrderInfoPage"));

  }

}