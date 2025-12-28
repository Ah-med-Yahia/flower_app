import '../../../../../config/base_response/base_response.dart';
import '../entities/verify_otp_code_entity.dart';
import '../repositories/forget_password_repo.dart';

class OtpVerificationUseCase {
  OtpVerificationUseCase(this._forgetPasswordRepo);

  final ForgetPasswordRepo _forgetPasswordRepo;

  Future<BaseResponse<VerifyOtpCodeEntity>> execute({
    required String? otpCode,
  }) => _forgetPasswordRepo.verifyOtpCode(resetCode: otpCode);
}
