import 'package:intl/intl.dart';

import 'models/account_model.dart';
import 'models/address.dart';

const String API_URL_STARTPOINT = "http://172.16.191.80:1234/smhu/api";
String ID;
String idStore;
//RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
//format number
final oCcy = new NumberFormat("#,##0", "en_US");
List<Address> address = new List();
String deliveryAddr = "";
String phoneNumber = "0123456789";
String fullName = "Phan Công Bình";
String note;
int status = 12;
int deliveryFee = 20000;
double money = 1000000;
Account account;
String customer;
String pass;
