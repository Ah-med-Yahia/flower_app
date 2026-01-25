import '../../../../../config/base_response/base_response.dart';
import '../entities/user_data_response.dart';

abstract interface class ProfileMainRepo {
  Future<BaseResponse<UserDataResponse>> getLoggedUserData();
}
