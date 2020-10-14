import 'package:capstone2020customerapp/screens/home.dart';
import 'package:capstone2020customerapp/screens/payment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InvoiceSumaryPage extends StatefulWidget {
  @override
  _InvoiceSumaryPage createState() => _InvoiceSumaryPage();
}

class _InvoiceSumaryPage extends State<InvoiceSumaryPage> {
  void showToast() {
    Fluttertoast.showToast(
        msg: 'Đặt Hàng Thành Công',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: const Color.fromRGBO(0, 141, 177, 1),
        textColor: Colors.white
    );

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return HomePage();
        }), ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody(),
            _buildSubBody(),
            _buildOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
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
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            child: Text(
              'Sơ Lược Hóa Đơn',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          for (var i = 0; i < 1; i++)
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(15.0),
                    height: 150.0,
                    child: Image.network(
                      'https://vinmec-prod.s3.amazonaws.com/images/20200708_040238_836115_15639394169.max-800x800.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Cá Hồi 300g',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '135,000đ\n',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Số Lượng: x1\n',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Container(
                                child: Text(
                                  '135,000đ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.all(15.0),
                  height: 150.0,
                  child: Image.network(
                    'https://fohlabeef.vn/wp-content/uploads/2019/05/th%C4%83n-n%E1%BB%99i-b%C3%B2-%C3%BAc-Tenderloin.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Thịt bò 450g',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.stars,
                              color: Colors.red,
                              size: 20.0,
                            ),
                          ),
                        ],

                      ),
                      Container(
                        child: Text(
                          '110,000đ\n',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Số Lượng: x1\n',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '90,000đ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSubBody() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Tổng Cộng(đã bao gồm thuế)\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '225,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Giảm Giá\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '-0đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Voucher\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '-0đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Phí giao hàng\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '20,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Phí đi chợ\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '50,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Tổng Tiền\n',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    '295,000đ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 141, 177, 1),
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

  Widget _buildOrderButton() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 70.0,
      child: RaisedButton(
        onPressed: showToast,
        textColor: Colors.white,
        color: const Color.fromRGBO(0, 141, 177, 1),
        child: Text(
          'Đặt Hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.0,
            letterSpacing: 2.0,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }


  changeThePage() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return PaymentPage();
        }), ModalRoute.withName('/'));
  }
}