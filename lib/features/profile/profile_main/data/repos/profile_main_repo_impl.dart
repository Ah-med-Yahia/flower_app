import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../domain/entities/user_data_response.dart';
import '../../domain/mappers/profile_main_mapper.dart';
import '../../domain/repos/profile_main_repo.dart';
import '../datasource/profile_main_remote_data_source.dart';

@Injectable(as: ProfileMainRepo)
class ProfileMainRepoImpl implements ProfileMainRepo {
  final ProfileMainRemoteDataSource _remoteDataSource;

  ProfileMainRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserDataResponse>> getLoggedUserData() async {
    return safeApiCall(() async {
      final response = await _remoteDataSource.getLoggedUserData();
      final toEntity =
          ProfileMainMapper.mapUserDataResponseDtoToUserDataResponse(response);
      return toEntity;
    });
  }
}
