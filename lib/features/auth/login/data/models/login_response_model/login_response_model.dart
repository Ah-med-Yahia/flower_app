import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'user_model.dart';

part 'login_response_model.g.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginResponseModel {
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "user")
    final UserModel user;
    @JsonKey(name: "token")
    final String token;

    LoginResponseModel({
        required this.message,
        required this.user,
        required this.token,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
