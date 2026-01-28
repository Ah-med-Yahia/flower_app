import '../../../../../config/base_response/base_response.dart';
import '../models/change_password_request_model/change_password_request.dart';
import '../models/change_password_response_model/change_password_response.dart';

abstract interface class ChangePasswordDataSource {
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  );
}
