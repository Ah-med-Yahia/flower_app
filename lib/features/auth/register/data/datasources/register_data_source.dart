import '../../../../../config/base_response/base_response.dart';
import '../models/register_request/register_request.dart';
import '../models/register_response/register_response.dart';

abstract class RegisterDataSource {
  Future<BaseResponse<RegisterResponseModel>> register(RegisterRequestModel request);
}
