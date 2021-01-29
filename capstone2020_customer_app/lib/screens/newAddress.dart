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

  List ward_binhtan = ["An Lạc A", "Bình Hưng Hòa", "Bình Hưng Hòa A", "Bình Hưng Hòa B", "Bình Trị Đông",
    "Bình Trị Đông A", "Bình Trị Đông B", "Tân Tạo", "Tân Tạo A", "An Lạc"];

  List street_binhtan = ["An Lạc" , "Ao Đôi", "Bà Hom", "Bến Lội", "Bình Long", "Bình Thành",
    "Bình Trị Đông", "Bùi Tư Toàn", "Cầu Kinh", "Cây Cám", "Dương Bá Cung", "Dương Tự Quán", "Đình Nghi Xuân"];

  List ward_binhthanh = ["Phường 1", "Phường 2", "Phường 3", "Phường 5", "Phường 6",
    "Phường 7", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15", "Phường 17", "Phường 19", "Phường 21", "Phường 22", "Phường 24", "Phường 25", "Phường 26", "Phường 27", "Phường 28"];

  List street_binhthanh = ["30/4" , "Bạch Đằng", "Bình Lợi", "Bùi Hữu Nghĩa", "Chu Văn An", "Đinh Bộ Lĩnh",
    "Điện Biên Phủ", "Hoàng Hoa Thám", "Lê Quang Định", "Ngô Đức Kế", "Nguyễn Xí", "Phạm Văn Đồng", "Xô Viết Nghệ Tĩnh"];

  List ward_govap = ["Phường 1", "Phường 3", "Phường 4", "Phường 5", "Phường 6",
    "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15", "Phường 16", "Phường 17"];

  List street_govap = ["An Hội" , "An Nhơn", "Bạch Đằng", "Dương Quảng Hàm", "Hoàng Minh Giám", "Huỳnh Văn Nghệ",
    "Lê Đức Thọ", "Lê Lai", "Lê Lợi", "Nguyễn Kiệm", "Nguyễn Thái Sơn", "Phạm Ngũ Lão", "Phan Huy Ích", "Phan Văn Trị", "Quang Trung"];

  List ward_phunhuan = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 13", "Phường 15", "Phường 17"];

  List street_phunhuan = ["Lê Văn Sỹ" , "Chiến Thắng", "Cô Bắc", "Cô Giang", "Đào Duy Anh", "Đào Duy Từ",
    "Hoàng Minh Giám", "Hoàng Văn Thụ", "Hồ Văn Huê", "Huỳnh Văn Bánh", "Lam Sơn", "Phan Đăng Lưu", "Phan Đình Phùng", "Trần Huy Liệu", "Trường Sa"];

  List ward_tanbinh = ["Phường 1", "Phường 2", "Phường 3", "Phường 4", "Phường 5",
    "Phường 6", "Phường 7", "Phường 8", "Phường 9", "Phường 10", "Phường 11", "Phường 12", "Phường 13", "Phường 14", "Phường 15"];

  List street_tanbinh = ["Âu Cơ" , "Bành Văn Trân", "Bàu Bàng", "Bình Giã", "Bùi Thị Xuân", "Cách Mạng Tháng 8",
    "Cộng Hòa", "Hoàng Hoa Thám", "Hoàng Minh Giám", "Hoàng Sa", "Hoàng Văn Thụ", "Huỳnh Văn Nghệ", "Lạc Long Quân", "Lê Văn Sỹ", "Lý Thường Kiệt"];

  List ward_tanphu = ["Hiệp Tân", "Hòa Thạnh", "Phú Thạnh", "Phú Thọ Hòa", "Phú Trung",
    "Sơn Kỳ", "Tân Quý", "Tân Sơn Nhì", "Tân Thành", "Tân Thới Hòa", "Tây Thạnh"];

  List street_tanphu = ["30 tháng 4" , "Âu Cơ", "Bác Ái", "Bờ Bao Tân Thắng", "Chu Văn An", "Độc Lập",
    "Lê Cao Lãng", "Lê Đình Thám", "Lê Đình Thụ", "Lê Khôi", "Nguyễn Nghiêm", "Thống Nhất", "Trần Hưng Đạo", "Trần Văn Giáp", "Trường Chinh"];

  List ward_thuduc = ["Linh Chiểu", "Bình Thọ", "Linh Tây", "Linh Trung", "Linh Xuân",
    "Bình Chiểu", "Hiệp Bình Chánh", "Hiệp Bình Phước", "Tam Bình", "Tam Phú", "Linh Đông", "Trường Thọ"];

  List street_thuduc = ["Bà Giang" , "Bác Ái", "Bình Chiểu", "Chu Mạnh Trinh", "Công Lý", "Dân Chủ",
    "Đoàn Kết", "Lê Quý Đôn", "Kha Vạn Cân", "Khổng Tử", "Khu Làng Đại Học", "Lam Sơn", "Linh Đông", "Linh Trung", "Phạm Văn Đồng"];
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
                      if(dist == "13")
                        for(int i = 0; i < ward_binhtan.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_binhtan[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "14")
                        for(int i = 0; i < ward_binhthanh.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_binhthanh[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "15")
                        for(int i = 0; i < ward_govap.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_govap[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "16")
                        for(int i = 0; i < ward_phunhuan.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_phunhuan[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "17")
                        for(int i = 0; i < ward_tanbinh.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_tanbinh[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "18")
                        for(int i = 0; i < ward_tanphu.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_tanphu[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "19")
                        for(int i = 0; i < ward_thuduc.length; i++)
                          DropdownMenuItem(
                            child: Text(ward_thuduc[i].toString()),
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
                        if(dist == "13"){
                          wardName = ward_binhtan[value - 1];
                        }
                        if(dist == "14"){
                          wardName = ward_binhthanh[value - 1];
                        }
                        if(dist == "15"){
                          wardName = ward_govap[value - 1];
                        }
                        if(dist == "16"){
                          wardName = ward_phunhuan[value - 1];
                        }
                        if(dist == "17"){
                          wardName = ward_tanbinh[value - 1];
                        }
                        if(dist == "18"){
                          wardName = ward_tanphu[value - 1];
                        }
                        if(dist == "19"){
                          wardName = ward_thuduc[value - 1];
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
                      if(dist == "13")
                        for(int i = 0; i < street_binhtan.length; i++)
                          DropdownMenuItem(
                            child: Text(street_binhtan[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "14")
                        for(int i = 0; i < street_binhthanh.length; i++)
                          DropdownMenuItem(
                            child: Text(street_binhthanh[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "15")
                        for(int i = 0; i < street_govap.length; i++)
                          DropdownMenuItem(
                            child: Text(street_govap[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "16")
                        for(int i = 0; i < street_phunhuan.length; i++)
                          DropdownMenuItem(
                            child: Text(street_phunhuan[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "17")
                        for(int i = 0; i < street_tanbinh.length; i++)
                          DropdownMenuItem(
                            child: Text(street_tanbinh[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "18")
                        for(int i = 0; i < street_tanphu.length; i++)
                          DropdownMenuItem(
                            child: Text(street_tanphu[i].toString()),
                            value: i + 1,
                          ),
                      if(dist == "19")
                        for(int i = 0; i < street_thuduc.length; i++)
                          DropdownMenuItem(
                            child: Text(street_thuduc[i].toString()),
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
                          streetName = street_3[value - 1];
                        }
                        if(dist == "4"){
                          streetName = street_4[value - 1];
                        }
                        if(dist == "5"){
                          streetName = street_5[value - 1];
                        }
                        if(dist == "6"){
                          streetName = street_6[value - 1];
                        }
                        if(dist == "7"){
                          streetName = street_7[value - 1];
                        }
                        if(dist == "8"){
                          streetName = street_8[value - 1];
                        }
                        if(dist == "9"){
                          streetName = street_9[value - 1];
                        }
                        if(dist == "10"){
                          streetName = street_10[value - 1];
                        }
                        if(dist == "11"){
                          streetName = street_11[value - 1];
                        }
                        if(dist == "12"){
                          streetName = street_12[value - 1];
                        }
                        if(dist == "13"){
                          wardName = street_binhtan[value - 1];
                        }
                        if(dist == "14"){
                          wardName = street_binhthanh[value - 1];
                        }
                        if(dist == "15"){
                          wardName = street_govap[value - 1];
                        }
                        if(dist == "16"){
                          wardName = street_phunhuan[value - 1];
                        }
                        if(dist == "17"){
                          wardName = street_tanbinh[value - 1];
                        }
                        if(dist == "18"){
                          wardName = street_tanphu[value - 1];
                        }
                        if(dist == "19"){
                          wardName = street_thuduc[value - 1];
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
    deliveryAddr = streetController.text + ", " + wardName + ", " + districtName + ", " + "Hồ Chí Minh";
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