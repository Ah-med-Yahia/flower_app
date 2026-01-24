import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_response_entity/change_password_response_entity.dart';

abstract class ChangePasswordRepo {
  Future<BaseResponse<ChangePasswordResponseEntity>> changePassword(
    ChangePasswordRequestEntity request,
  );
}
