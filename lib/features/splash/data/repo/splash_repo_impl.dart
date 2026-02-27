import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/splash/data/data_sources/splash_local_data_source.dart';
import 'package:flower_app/features/splash/domain/repo/splash_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashRepo)
class SplashRepoImpl implements SplashRepo {
  final SplashLocalDataSource _splashLocalDataSource;

  SplashRepoImpl(this._splashLocalDataSource);
  @override
  Future<BaseResponse<bool>> isLogged() async {
    final response = await _splashLocalDataSource.isLogged();
    return response.when(
      success: (isLogged) {
        if (isLogged) {
          return const BaseResponse<bool>.success(true);
        }

        return const BaseResponse<bool>.success(false);
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
