import 'package:online_exam_app/features/authentication/forget_password/domian/entities/verify_otp_code_entity.dart';
import '../../../../../config/base_response/base_response.dart';
import '../repositories/forget_password_repo.dart';

class OtpVerificationUseCase {
  OtpVerificationUseCase(this._forgetPasswordRepo);

  final ForgetPasswordRepo _forgetPasswordRepo;

  Future<BaseResponse<VerifyOtpCodeEntity>> execute({
    required String otpCode,
  }) => _forgetPasswordRepo.verifyOtpCode(resetCode: otpCode);
}
