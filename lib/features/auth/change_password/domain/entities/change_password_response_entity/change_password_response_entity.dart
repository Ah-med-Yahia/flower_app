import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponseEntity {
  final String? message;
  final String? token;

  const ChangePasswordResponseEntity({this.message, this.token});

  factory ChangePasswordResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}
