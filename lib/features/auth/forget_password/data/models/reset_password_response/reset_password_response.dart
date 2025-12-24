import '../../../domain/entities/reset_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseFromJson(json);
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
  ResetPasswordEntity toEntity() =>
      ResetPasswordEntity(message: message ?? '', token: token ?? '');
}
