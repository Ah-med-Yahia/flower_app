import 'package:injectable/injectable.dart';

import '../../../data/datasource/profile_main_remote_data_source.dart';
import '../../../data/models/user_data_response_dto.dart';
import '../../api_client/profile_main_api_client.dart';

@Injectable(as: ProfileMainRemoteDataSource)
class ProfileMainRemoteDataSourceImpl implements ProfileMainRemoteDataSource {
  final ProfileMainApiClient _apiClient;

  ProfileMainRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserDataResponseDto> getLoggedUserData() async =>
      await _apiClient.getLoggedUserData();
}
