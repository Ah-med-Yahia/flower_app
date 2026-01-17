import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';
@JsonSerializable()
class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String gender;

  const RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
