import 'package:intl/intl.dart';

import 'models/address.dart';

const String API_URL_STARTPOINT = "http://192.168.43.81:8084/smhu/api";
String ID = "cust45620201028121453";
//RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
//format number
final oCcy = new NumberFormat("#,##0", "en_US");
List<Address> address = new List();
String deliveryAddr = "";
String phoneNumber = "0123456789";
String fullName = "Phan Công Bình";
String note;
int deliveryFee = 20000;
double money = 1000000;
