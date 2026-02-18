import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/api_constants.dart';
import '../../data/models/user_data_response_dto.dart';

part 'profile_main_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileMainApiClient {
  @factoryMethod
  factory ProfileMainApiClient(Dio dio) = _ProfileMainApiClient;

  @GET(ApiConstants.profileDataEndPoint)
  Future<UserDataResponseDto> getLoggedUserData();
}
