import 'package:capstone2020customerapp/models/addr_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class Customer{
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
  AddressModel addressModel;


  Customer(
      this.id,
      this.username,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phone,
      this.dob,
      this.role,
      this.numSuccess,
      this.numCancel,
      this.wallet,
      this.addressModel
      );

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

}