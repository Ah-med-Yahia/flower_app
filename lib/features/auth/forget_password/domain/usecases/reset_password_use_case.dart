import '../../../../../config/base_response/base_response.dart';
import '../entities/reset_password_entity.dart';
import '../repositories/forget_password_repo.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._forgetPasswordRepo);

  final ForgetPasswordRepo _forgetPasswordRepo;

  Future<BaseResponse<ResetPasswordEntity>> execute({
    required String? email,
    required String? newPassword,
  }) =>
      _forgetPasswordRepo.resetPassword(email: email, newPassword: newPassword);
}