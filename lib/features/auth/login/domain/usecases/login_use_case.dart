import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/login_request_entity.dart';
import '../repositories/login_repository.dart';

@injectable
class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<BaseResponse<void>> call(
    LoginRequestEntity request,
    bool remembered,
  ) => _loginRepository.login(request, remembered);
}
