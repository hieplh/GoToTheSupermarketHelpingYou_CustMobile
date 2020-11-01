import 'models/address.dart';

const String API_URL_STARTPOINT = "http://172.16.188.245:1234//smhu/api";
String ID = "cust12320201029122924";
RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
List<Address> address = new List();
String deliveryAddr;
String phoneNumber = "0123456789";
String fullName = "Phan Công Bình";
String note;