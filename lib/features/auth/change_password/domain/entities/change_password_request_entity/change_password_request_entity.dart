import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_entity.g.dart';

@JsonSerializable()
class ChangePasswordRequestEntity {
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'newPassword')
  final String? newPassword;

  const ChangePasswordRequestEntity({this.password, this.newPassword});

  factory ChangePasswordRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestEntityToJson(this);
}
