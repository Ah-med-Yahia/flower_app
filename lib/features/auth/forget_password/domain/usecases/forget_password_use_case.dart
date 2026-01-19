import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/forget_password_entity.dart';
import '../repositories/forget_password_repo.dart';

@injectable
class ForgetPasswordUseCase {
  const ForgetPasswordUseCase(this._forgetPasswordRepo);

  final ForgetPasswordRepo _forgetPasswordRepo;

  Future<BaseResponse<ForgetPasswordEntity>> execute({
    required String? email,
  }) => _forgetPasswordRepo.forgetPassword(email: email);
}
