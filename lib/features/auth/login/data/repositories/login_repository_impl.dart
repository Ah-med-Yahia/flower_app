import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/local/local_login_data_source.dart';
import '../datasources/remote/remote_login_data_source.dart';
import '../mapper/login_request_mapper.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final RemoteLoginDataSource remoteDataSource;
  final LocalLoginDataSource localDataSource;

  LoginRepositoryImpl(this.remoteDataSource, this.localDataSource);
  @override
  Future<BaseResponse<void>> login(
    LoginRequestEntity request,
    bool remembered,
  ) async {
    final response = await remoteDataSource.login(request.toModel());
    return response.map(
      success: (response) async {
        final loginResponse = response.data;
        final localResponse = await localDataSource.saveLoggedUserData(
          token: loginResponse.token,
          user: loginResponse.user,
        );
        return localResponse.map(
          success: (s) {
            return const BaseResponse<void>.success(null);
          },
          failure: (f) {
            return BaseResponse<void>.failure(f.errorHandler);
          },
        );
      },
      failure: (failure) {
        return BaseResponse<void>.failure(failure.errorHandler);
      },
    );
  }
}
