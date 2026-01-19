import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/verify_otp_code_entity.dart';

part 'verify_otp_code_response.g.dart';

@JsonSerializable()
class VerifyOtpCodeResponse {
  const VerifyOtpCodeResponse({required this.status});

  final String? status;

  factory VerifyOtpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpCodeResponseToJson(this);

  VerifyOtpCodeEntity toEntity() => VerifyOtpCodeEntity(status: status ?? "");
}
