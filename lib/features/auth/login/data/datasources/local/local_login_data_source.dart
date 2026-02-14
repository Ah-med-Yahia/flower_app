import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response_model/user_model.dart';

abstract class LocalLoginDataSource {
  Future<BaseResponse<void>> saveLoggedUserData({
    required String token,
    required UserModel user,
    required bool rememberMe,
  });
}
