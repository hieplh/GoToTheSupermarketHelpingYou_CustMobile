import 'package:capstone2020customerapp/models/account_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'login_model.g.dart';

@JsonSerializable()
class Login{
  String password;
  String role;
  String username;

  Login(
      this.username,
      );

  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);

}