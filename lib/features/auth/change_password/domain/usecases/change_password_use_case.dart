import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/change_password_request_entity/change_password_request_entity.dart';
import '../repositories/change_password_repo.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<void>> call(ChangePasswordRequestEntity request) =>
      _repo.changePassword(request);
}
