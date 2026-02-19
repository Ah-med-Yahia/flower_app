import 'package:flower_app/features/tabs/profile/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'newPassword')
  final String? newPassword;

  const ChangePasswordRequest({this.password, this.newPassword});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);

  factory ChangePasswordRequest.fromEntity(ChangePasswordRequestEntity entity) {
    return ChangePasswordRequest(
      password: entity.password,
      newPassword: entity.newPassword,
    );
  }
}
