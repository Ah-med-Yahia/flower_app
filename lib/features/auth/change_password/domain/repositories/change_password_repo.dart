import '../../../../../config/base_response/base_response.dart';
import '../entities/change_password_request_entity/change_password_request_entity.dart';

abstract interface class ChangePasswordRepo {
  Future<BaseResponse<void>> changePassword(
    ChangePasswordRequestEntity request,
  );
}
