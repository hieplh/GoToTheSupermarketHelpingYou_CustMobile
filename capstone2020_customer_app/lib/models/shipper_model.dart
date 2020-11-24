import 'package:capstone2020customerapp/models/addr_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipper_model.g.dart';

@JsonSerializable()
class Shipper{
  String id;
  String username;
  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone;
  String dob;
  String role;
  int numDelivery;
  int numCancel;
  double wallet;


  Shipper(
      this.id,
      this.username,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.phone,
      this.dob,
      this.role,
      this.numDelivery,
      this.numCancel,
      this.wallet
      );

  factory Shipper.fromJson(Map<String, dynamic> json) =>
      _$ShipperFromJson(json);

  Map<String, dynamic> toJson() => _$ShipperToJson(this);

}