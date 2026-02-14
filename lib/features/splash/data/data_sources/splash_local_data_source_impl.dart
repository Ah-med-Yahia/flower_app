import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/splash/data/data_sources/splash_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashLocalDataSource)
class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final SecureStorageService _secureStorageService;

  SplashLocalDataSourceImpl(this._secureStorageService);
  @override
  Future<BaseResponse<bool>> isLogged() async {
    final response = await _secureStorageService.readBool(
      StorageKeys.isLoggedIn,
    );
    return response.when(
      success: (s) => BaseResponse<bool>.success(s ?? false),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }
}
