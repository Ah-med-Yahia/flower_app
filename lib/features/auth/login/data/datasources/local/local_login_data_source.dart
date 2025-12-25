
import '../../../../../../config/base_response/base_response.dart';
import '../../models/login_response_model/user_model.dart';

abstract interface class LocalLoginDataSource {
  Future<BaseResponse<void>> saveLoggedUserData({
    required String token,
    required UserModel user,
  });
}