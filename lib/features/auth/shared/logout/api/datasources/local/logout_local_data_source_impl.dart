import 'package:injectable/injectable.dart';

import '../../../../../../../config/base_response/base_response.dart';
import '../../../../../../../config/cache_modules/secure_storage_module.dart';
import '../../../../../../../core/constants/cache_constants.dart';
import '../../../data/datasoources/local/logout_local_data_source.dart';

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
    return const BaseResponse<void>.success(null);
  }
}
