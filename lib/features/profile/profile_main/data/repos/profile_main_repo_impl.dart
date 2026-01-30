import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../domain/entities/term_section_entity.dart';
import '../../domain/entities/user_data_response.dart';
import '../../domain/mappers/profile_main_mapper.dart';
import '../../domain/repos/profile_main_repo.dart';
import '../datasource/local/profile_main_local_data_source.dart';
import '../datasource/profile_main_remote_data_source.dart';
import '../mappers/terms_mapper.dart';

@Injectable(as: ProfileMainRepo)
class ProfileMainRepoImpl implements ProfileMainRepo {
  final ProfileMainRemoteDataSource _remoteDataSource;
  final ProfileMainLocalDataSource _localDataSource;

  ProfileMainRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<UserDataResponse>> getLoggedUserData() async {
    return safeApiCall(() async {
      final response = await _remoteDataSource.getLoggedUserData();
      final toEntity =
          ProfileMainMapper.mapUserDataResponseDtoToUserDataResponse(response);
      return toEntity;
    });
  }

  @override
  Future<BaseResponse<TermsAndConditionsEntity>> getTermsData() async {
    return safeApiCall(() async {
      final response = await _localDataSource.getTermsData();
      return TermsMapper.toEntity(response);
    });
  }
}
