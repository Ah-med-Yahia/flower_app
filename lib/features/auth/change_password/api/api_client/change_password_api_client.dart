import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../data/models/change_password_request_model/change_password_request.dart';
import '../../data/models/change_password_response_model/change_password_response.dart';

part 'change_password_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(ApiConstants.changePasswordEndPoint)
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest request,
  );
}
