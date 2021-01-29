import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'models/account_model.dart';
import 'models/addToCart.dart';
import 'models/address.dart';
import 'models/food_model.dart';
import 'models/history_model.dart';

const String API_URL_STARTPOINT = "http://smhu.ddns.net:8084/smhu/api";
const String API_URL = "http://smhu.ddns.net:8084/smhu/api";
String ID;
String idStore;
//RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
//format number
final oCcy = new NumberFormat("#,##0", "en_US");
List<Address> address = new List();
String deliveryAddr = "";
String phoneNumber = "${account.username}";
String fullName = "${utf8.decode(latin1.encode(account.fullname))}";
String note;
int status = 12;
double deliveryFee = 20000;
double shoppingFee = 50000;
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
List<Data> listCart = new List();
int badgeData = 0;
double total = 0;
Map<String, int> quantity = new Map();