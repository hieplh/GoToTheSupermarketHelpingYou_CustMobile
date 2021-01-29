import 'package:capstone2020customerapp/models/addr_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class Customer{
  String username;
  String fullname;
  String dob;
  String role;
  int numSuccess;
  int numCancel;
  double wallet;
  List<AddressModel> addresses;


  Customer(
      this.username,
      this.fullname,
      this.dob,
      this.role,
      this.numSuccess,
      this.numCancel,
      this.wallet,
      this.addresses
      );

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}