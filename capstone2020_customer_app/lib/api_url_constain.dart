import 'models/address.dart';

const String API_URL_STARTPOINT = "http://smhu.ddns.net/smhu/api";
String ID = "cust12320201028231641";
RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
List<Address> address = new List();
String deliveryAddr;
String phoneNumber = "0123456789";
String fullName = "Phan Công Bình";
String note;
int deliveryFee = 20000;
double money = 900000;
