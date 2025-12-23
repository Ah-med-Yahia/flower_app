import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/authentication/forget_password/domian/entities/forget_password_entity.dart';
import 'package:online_exam_app/features/authentication/forget_password/domian/entities/reset_password_entity.dart';
import 'package:online_exam_app/features/authentication/forget_password/domian/entities/verify_otp_code_entity.dart';

abstract interface class ForgetPasswordRepo {
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  });

  Future<BaseResponse<VerifyOtpCodeEntity>> verifyOtpCode({
    required String resetCode,
  });

  Future<BaseResponse<ResetPasswordEntity>> restPassword({
    required String email,
    required String newPassword,
  });
}
