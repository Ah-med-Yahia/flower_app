import 'package:flower_app/features/auth/change_password/domain/entities/change_password_response_entity/change_password_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "token")
  final String token;

  const ChangePasswordResponse({
    required this.message,
    required this.token,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

  ChangePasswordResponseEntity toEntity() {
    return ChangePasswordResponseEntity(
      message: message,
      token: token,
    );
  }
}
