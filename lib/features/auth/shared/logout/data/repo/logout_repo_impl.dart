import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/shared/logout/data/datasoources/local/logout_local_data_source.dart';
import 'package:flower_app/features/auth/shared/logout/domain/repo/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImpl implements LogoutRepo {
  final LogoutLocalDataSource _logoutLocalDataSource;
  LogoutRepoImpl(this._logoutLocalDataSource);
  @override
  Future<BaseResponse<void>> clearUserTokens() async {
    final response = await _logoutLocalDataSource.clearUserTokens();
    return response.when(
      success: (success) => BaseResponse.success(success),
      failure: (failure) => BaseResponse.failure(failure),
    );
  }
}
