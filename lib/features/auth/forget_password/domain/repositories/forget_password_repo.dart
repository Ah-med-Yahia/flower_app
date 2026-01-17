import '../../../../../config/base_response/base_response.dart';
import '../entities/forget_password_entity.dart';
import '../entities/reset_password_entity.dart';
import '../entities/verify_otp_code_entity.dart';

abstract interface class ForgetPasswordRepo {
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String? email,
  });

  Future<BaseResponse<VerifyOtpCodeEntity>> verifyOtpCode({
    required String? resetCode,
  });

  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String? email,
    required String? newPassword,
  });
}
