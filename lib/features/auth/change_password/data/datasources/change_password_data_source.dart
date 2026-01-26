import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/change_password/data/models/change_password_request_model/change_password_request.dart';
import 'package:flower_app/features/auth/change_password/data/models/change_password_response_model/change_password_response.dart';

abstract interface class ChangePasswordDataSource {
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  );
}
