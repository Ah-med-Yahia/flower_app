import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tabs/profile/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/tabs/profile/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<void>> call(ChangePasswordRequestEntity request) =>
      _repo.changePassword(request);
}
