import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/cache_modules/secure_storage_module.dart';
import '../../../../../../core/constants/cache_constants.dart';
import '../../../data/datasources/local/local_login_data_source.dart';
import '../../../data/models/login_response_model/user_model.dart';

@Singleton(as: LocalLoginDataSource)
class LoginLocalDataSourceImpl implements LocalLoginDataSource {
  final SecureStorageService secureStorageService;
  LoginLocalDataSourceImpl({required this.secureStorageService});
  @override
  Future<BaseResponse<void>> saveLoggedUserData({
    required String token,
    required UserModel user,
  }) async {
    final responses = await Future.wait([
      secureStorageService.saveAuthTokens(accessToken: token),
      secureStorageService.writeBool(StorageKeys.isLoggedIn, true),
      secureStorageService.writeJson(StorageKeys.userModel, user.toJson()),
    ]);
    for (final r in responses) {
      final failure = r.map(success: (_) => null, failure: (f) => f);

      if (failure != null) {
        return BaseResponse<void>.failure(failure.errorhandeler);
      }
    }
    return BaseResponse<void>.success(null);
  }
}
