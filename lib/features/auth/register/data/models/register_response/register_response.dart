import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final String message;
  final User user;
  final String token;

  const RegisterResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
