import '../../models/forget_password_response/forget_password_response.dart';
import '../../models/reset_password_response/reset_password_response.dart';
import '../../models/verify_otp_code_response/verify_otp_code_response.dart';

abstract interface class ForgetPasswordRemoteDataSource {
  Future<ForgetPasswordResponse> forgetPassword({required String email});

  Future<VerifyOtpCodeResponse> verifyOtpCode({required String resetCode});

  Future<ResetPasswordResponse> resetPassword({
    required String email,
    required String newPassword,
  });
}
