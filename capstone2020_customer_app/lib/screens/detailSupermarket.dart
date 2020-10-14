import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/supermarket.dart';
import 'package:flutter/material.dart';

class DetailSupermarketPage extends StatefulWidget {
  @override
  _DetailSupermarketPage createState() => _DetailSupermarketPage();
}
FocusNode myFocusNode = new FocusNode();
class _DetailSupermarketPage extends State<DetailSupermarketPage> {
  String search;
  TextEditingController searchController = new TextEditingController();
  List<String> img = ["facebook.png", "facebook.png", "facebook.png"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
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
              'Chọn Địa Chỉ Siêu Thị',
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
                  labelText: 'Tìm kiếm địa chỉ Siêu Thị',
                  hintText: 'Nhập địa chỉ siêu thị',
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
                      color: myFocusNode.hasFocus
                          ? const Color.fromRGBO(0, 141, 177, 1)
                          : Colors.black),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorText: snapshot.error,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'PROMO',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'AEON',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Supermarket',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      '30 Bờ Bao Tân Thắng, Phường Sơn Kỳ, Quận Tân Phú, Tp.Hồ Chí Minh.',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[900],
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 150,
                padding: EdgeInsets.only(bottom: 10.0, right: 15.0),
                child: Image.network(
                    'https://aeonmall-vietnam.com/wp-content/uploads/2017/01/icon-mall-01-1.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
              ),
            ),
          ),
          for (String image in img)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                leading: Image.network('https://diadiemanuong.edu.vn/wp-content/uploads/2020/08/tphcm-benh-nhan-450-tung-di-bo-den-aeon-mall-binh-tan-it-nhat-6-lan-mua-thuc-an-63f4672a637317057186251385.jpg'),
                    title: Text(
                      'AEON MALL Binh Tan',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      '21phút . 1.8km',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey[500],
                        fontSize: 14.0,
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    onTap: goToHomePage,
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return SupermarketPage();
    }), ModalRoute.withName('/'));
  }

  goToHomePage() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }
}
