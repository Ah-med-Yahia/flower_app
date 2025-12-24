import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/auth/login/data/mapper/login_request_mapper.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/local/local_login_data_source.dart';
import '../datasources/remote/remote_login_data_source.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final RemoteLoginDataSource remoteDataSource;
  final LocalLoginDataSource localDataSource;

  LoginRepositoryImpl(this.remoteDataSource, this.localDataSource);
  @override
  Future<BaseResponse<void>> login(LoginRequestEntity request) async {
    final response = await remoteDataSource.login(request.toModel());
    return response.map(
      success: (response) {
        final loginResponse = response.data;
        localDataSource.saveLoggedUserData(
          token: loginResponse.token,
          user: loginResponse.user,
        );
        return BaseResponse.success(null);
      },
      failure: (failure) {
        return BaseResponse.failure(failure.errorhandeler);
      },
    );
  }
}
