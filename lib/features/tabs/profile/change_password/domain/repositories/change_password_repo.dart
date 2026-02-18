import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tabs/profile/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';

abstract interface class ChangePasswordRepo {
  Future<BaseResponse<void>> changePassword(
    ChangePasswordRequestEntity request,
  );
}
