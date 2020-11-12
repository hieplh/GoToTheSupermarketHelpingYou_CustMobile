import 'package:capstone2020customerapp/models/addr_model.dart';
import 'package:capstone2020customerapp/models/time_travel_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_detail_model.dart';
part 'account_model.g.dart';

@JsonSerializable()
class Account{
  String id;
  String username;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone;
  String dob;
  String role;
  int numSuccess;
  int numCancel;
  double wallet;
  List<AddressModel> addresses;

  Account(
      this.id,
      this.username,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phone,
      this.dob,
      this.role,
      this.numCancel,
      this.numSuccess,
      this.wallet,
      this.addresses,
      );

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

}