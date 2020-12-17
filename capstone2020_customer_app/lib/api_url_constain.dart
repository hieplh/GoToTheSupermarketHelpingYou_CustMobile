import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'models/account_model.dart';
import 'models/address.dart';
import 'models/food_model.dart';
import 'models/history_model.dart';

const String API_URL_STARTPOINT = "http://192.168.1.32:8084/smhu/api/";
String ID;
String idStore;
//RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
//format number
final oCcy = new NumberFormat("#,##0", "en_US");
List<Address> address = new List();
String deliveryAddr = "";
String phoneNumber = "${account.phone}";
String fullName = "${utf8.decode(latin1.encode(account.lastName)) + " " + utf8.decode(latin1.encode(account.middleName)) + " " + utf8.decode(latin1.encode(account.firstName))}";
String note;
int status = 12;
int deliveryFee = 20000;
int shoppingFee = 50000;
double money = 1000000;
Account account;
String customer;
String pass;
int mapCount = 23;
LatLng DEST_LOCATION = LatLng(10.805046003444534, 106.7367919390238);
LatLng SOURCE_LOCATION = LatLng(10.847790308969985, 106.7520011120352);
List<FoodModel> pig = new List();
List<FoodModel> beef = new List();
List<FoodModel> fish = new List();
List<FoodModel> chicken = new List();
List<FoodModel> vegetable = new List();
List<String> listExample = [];