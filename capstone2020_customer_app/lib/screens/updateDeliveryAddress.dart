import 'dart:convert';

import 'package:capstone2020customerapp/api_url_constain.dart';
import 'package:capstone2020customerapp/models/addToCart.dart';
import 'package:capstone2020customerapp/models/address.dart';
import 'package:capstone2020customerapp/screens/orderInfo.dart';
import 'package:capstone2020customerapp/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
class UpdateAddressPage extends StatefulWidget {

  @override
  _UpdateAddressPage createState() => _UpdateAddressPage();
}

class _UpdateAddressPage extends State<UpdateAddressPage> {

  void showFailToast() {
    //setState(() {
    Fluttertoast.showToast(
        msg: "Update thất bại",
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
        msg: 'Update Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );
    //});
  }
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

  List ward_3 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14"];

  List street_3 = ["Bà Huyện Thanh Quan" , "Cách Mạng Tháng 8", "Cao Thắng", "Điện Biên Phủ", " Hai Bà Trưng", "Hoàng Sa",
    "Hồ Xuân Hương", "Huỳnh Văn Bánh", "Lê Quý Đôn", "Lý Chính Thắng", "Lê Văn Sỹ", "Nam Kỳ Khởi Nghĩa", "Pasteur"];

  List ward_4 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 6",
    "Phường 8", "Phường 9", "Phường 10", "Phường 13", "Phường 14", "Phường 15", "Phường 16", "Phường 18"];

  List street_4 = ["Tôn Thất Thuyết" , "Trương Đình Hội", "Tôn Đản", "Nguyễn Trường Tộ", "Nguyễn Thần Hiến", "Nguyễn Tất Thành",
    "Hoàng Diệu", "Đoàn Văn Bơ", "Nguyễn Khoái", "Nguyễn Hữu Hào", "Ngô Văn Sở", "Lê Văn Linh", "Khánh Hội"];

  List ward_5 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14"];

  List street_5 = ["Võ Văn Kiệt" , "Võ Trường Toản", "Vạn Kiếp", "Phan Văn Trị", "Nguyễn Văn Cừ", "Trần Bình Trọng",
    "Trần Chánh Chiếu", "Trần Hưng Đạo", "Trần Phú", "Triệu Quang Phục", "Trần Tướng Công", "Trần Phú", "Kim Biên"];

  List ward_6 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14"];

  List street_6 = ["Bà Hom" , "Bà Lài", "Bến Bãi Sậy", "Bến Lò Gốm", "Bến Phú Lâm", "Bình Phú",
    "Bình Tây", "Gia Phú", "Hậu Giang", "Tân Hòa Đông", "Võ Văn Kiệt", "Tháp Mười", "Tân Hóa"];

  List ward_7 = ["Bình Thuận", "Phú Mỹ", "Phú Thuận", "Tân Hưng", "Tân Kiểng",
    "Tân Phong", "Tân Phú", "Tân Quy", "Tân Thuận Đông", "Tân Thuận Tây"];

  List street_7 = ["Bến Nghé" , "Bùi Văn Ba", "Cao Thị Chính", "Huỳnh Tấn Phát", "Hoàng Văn Thái", "Nguyễn Thị Thập",
    "Nguyễn Thị Xiếu", "Tân Mỹ", "Tân Phú", "Tân Thuận Tây", "Trần Văn Khánh", "Võ Thị Nhờ", "Nguyễn Lương Bằng"];

  List ward_8 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15", "Phường 16"];

  List street_8 = ["Võ Văn Kiệt" , "Bùi Minh Trực", "Đường số 1", "Đường số 16", "Đường số 41", "Dương Bạch Mai",
    "Bến Bình Đông", "Bình Đức", "Chánh Hưng", "Hưng Phú", "Mạc Vân", "Mễ Cốc", "Phạm Đức Sơn"];

  List ward_9 = ["Phường Tăng Nhơn Phú B", "Phường Hiệp Phú", "Phường Phước Bình", "Phường Phước Long A", "Phường Long Phước",
    "Phường Long Bình", "Phường Long Thạnh Mỹ", "Phường Tăng Nhơn Phú A", "Phường Tân Phú", "Phường Trường Thạnh", "Phường Phú Hữu", "Phường Long Trường", "Phường Phước Long B"];

  List street_9 = [" Đường số 5" , "Đường số 5A", "Bưng Sáu Xã", "Bùi Xương Trạch", "Bưng Ông Thoàn", "Ngô Quyền",
    "Nguyễn Công Trứ", "Nguyễn Thái Học", "Nguyễn Văn Thạnh", "Đại Lộ 2", "Đại lộ 3", "Dân Chủ", "Đỗ Xuân Hợp"];

  List ward_10 = ["Phường 1", "Phường 2", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15"];

  List street_10 = ["3 Tháng 2" , "Ba Vì", "Điện Biên Phủ", "Lý Thái Tổ", "Lý Thường Kiệt", "Sư Vạn Hạnh",
    "Vĩnh Viễn", "Trường Sơn", "Lạc Long Quân", "Lê Hồng Phong", "Nguyễn Kim", "Tô Hiến Thành", "Trần Bình Trọng"];

  List ward_11 = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15", "Phường 16"];

  List street_11 = ["Âu Cơ" , "Ba Tháng Hai", "Công Chúa Ngọc Hân", "Lý Thường Kiệt", "Vĩnh Viễn", "Tuệ Tĩnh",
    "Trịnh Đình Trọng", "Tôn Thất Hiệp", "Thái Phiên", "Lý Nam Đế", "Tân Khai", "Nguyễn Văn Phú", "Phan Xích Long"];

  List ward_12 = ["An Phú Đông", "Đông Hưng Thuận", "Hiệp Thành", "Tân Chánh Hiệp", "Tân Hưng Thuận",
    "Tân Thới Hiệp", "Tân Thới Nhất", "Thạnh Lộc", "Thạnh Xuân", "Thới An", "Trung Mỹ Tây"];

  List street_12 = ["Đường số 37" , "Đường D5", "An Lộc", "An Phú Đông", "Cầu Rạch Gia", "Hà Huy Giáp",
    "Hà Thị Khiêm", "Hiệp Thành 23", "Lâm Thị Hồ", "Nguyễn Thị Căn", "Quốc Lộ 1A", "Đường Song Hành Quốc Lộ 22", "Tô Ký"];

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
                      if(dist == "3")
                        for(int i = 0; i < ward_3.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_3[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "4")
                        for(int i = 0; i < ward_4.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_4[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "5")
                        for(int i = 0; i < ward_5.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_5[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "6")
                        for(int i = 0; i < ward_6.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_6[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "7")
                        for(int i = 0; i < ward_7.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_7[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "8")
                        for(int i = 0; i < ward_8.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_8[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "9")
                        for(int i = 0; i < ward_9.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_9[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "10")
                        for(int i = 0; i < ward_10.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_10[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "11")
                        for(int i = 0; i < ward_11.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_11[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "12")
                        for(int i = 0; i < ward_12.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_12[i].toString()),
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
                        if(dist == "3"){
                          wardName = ward_3[value - 1];
                        }
                        if(dist == "4"){
                          wardName = ward_4[value - 1];
                        }
                        if(dist == "5"){
                          wardName = ward_5[value - 1];
                        }
                        if(dist == "6"){
                          wardName = ward_6[value - 1];
                        }
                        if(dist == "7"){
                          wardName = ward_7[value - 1];
                        }
                        if(dist == "8"){
                          wardName = ward_8[value - 1];
                        }
                        if(dist == "9"){
                          wardName = ward_9[value - 1];
                        }
                        if(dist == "10"){
                          wardName = ward_10[value - 1];
                        }
                        if(dist == "11"){
                          wardName = ward_11[value - 1];
                        }
                        if(dist == "12"){
                          wardName = ward_12[value - 1];
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
                      if(dist == "3")
                        for(int i = 0; i < street_3.length; i++)
                          DropdownMenuItem(
                            child: Text(street_3[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "4")
                        for(int i = 0; i < street_4.length; i++)
                          DropdownMenuItem(
                            child: Text(street_4[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "5")
                        for(int i = 0; i < street_5.length; i++)
                          DropdownMenuItem(
                            child: Text(street_5[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "6")
                        for(int i = 0; i < street_6.length; i++)
                          DropdownMenuItem(
                            child: Text(street_6[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "7")
                        for(int i = 0; i < street_7.length; i++)
                          DropdownMenuItem(
                            child: Text(street_7[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "8")
                        for(int i = 0; i < street_8.length; i++)
                          DropdownMenuItem(
                            child: Text(street_8[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "9")
                        for(int i = 0; i < street_9.length; i++)
                          DropdownMenuItem(
                            child: Text(street_9[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "10")
                        for(int i = 0; i < street_10.length; i++)
                          DropdownMenuItem(
                            child: Text(street_10[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "11")
                        for(int i = 0; i < street_11.length; i++)
                          DropdownMenuItem(
                            child: Text(street_11[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "12")
                        for(int i = 0; i < street_12.length; i++)
                          DropdownMenuItem(
                            child: Text(street_12[i].toString()),
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
                        if(dist == "3"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "4"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "5"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "6"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "7"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "8"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "9"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "10"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "11"){
                          streetName = street_2[value - 1];
                        }
                        if(dist == "12"){
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
                  'Cập nhật địa chỉ',
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
//    Address addr = new Address("Phan Công Bình", "0123456789", "Hồ Chí Minh", districtName, wardName, streetController.text + " " + streetName);
//    address.add(addr);
//    deliveryAddr = streetController.text + ", " + districtName + ", " + wardName + ", " + "Hồ Chí Minh";
//    //print(streetController.text);
  print(streetController.text + " " +streetName);
  print(wardName);
  print(districtName);
    var url = API_URL_STARTPOINT + '/account/address';
    var response = await http.put(Uri.parse(url),
        headers: {
          'Content-type' : 'application/json',
          "Accept": "application/json",
        },
        body: json.encode(
            {
              "addresses": [
                {
                  "addr1": streetController.text + " " +streetName,
                  "addr2": wardName,
                  "addr3": districtName,
                  "addr4": "Tp.HCM"
                }
              ],
              "role": "customer",
              "username": "${account.username}"
            }
        ));

    if(response.statusCode == 200){
      showSuccessToast();
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }else{
      showFailToast();
    }

  }

}