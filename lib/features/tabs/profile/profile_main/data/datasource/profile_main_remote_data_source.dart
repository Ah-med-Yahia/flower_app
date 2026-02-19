import '../models/user_data_response_dto.dart';

abstract interface class ProfileMainRemoteDataSource {
  Future<UserDataResponseDto> getLoggedUserData();
}
