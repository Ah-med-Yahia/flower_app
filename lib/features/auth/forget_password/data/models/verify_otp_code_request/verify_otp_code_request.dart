import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_code_request.g.dart';

@JsonSerializable()
class VerifyOtpCodeRequest {
  const VerifyOtpCodeRequest({required this.resetCode});

  factory VerifyOtpCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpCodeRequestFromJson(json);

  final String resetCode;

  Map<String, dynamic> toJson() => _$VerifyOtpCodeRequestToJson(this);
}
