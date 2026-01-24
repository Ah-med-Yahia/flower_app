import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/auth/shared/logout/data/datasoources/local/logout_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutLocalDataSource)
class LogoutLocalDataSourceImpl implements LogoutLocalDataSource {
  final SecureStorageService secureStorageService;
  LogoutLocalDataSourceImpl(this.secureStorageService);
  @override
  Future<BaseResponse<void>> clearUserTokens() async {
    final responses = await Future.wait([
      secureStorageService.clearAuthTokens(),
      secureStorageService.delete(StorageKeys.isLoggedIn),
      secureStorageService.delete(StorageKeys.userModel),
    ]);
    for (final r in responses) {
      final failure = r.map(success: (_) => null, failure: (f) => f);

      if (failure != null) {
        return BaseResponse<void>.failure(failure.errorHandler);
      }
    }
    return BaseResponse<void>.success(null);
  }
}
