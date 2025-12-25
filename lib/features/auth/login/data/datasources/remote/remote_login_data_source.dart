import '../../../../../../config/base_response/base_response.dart';
import '../../models/login_request_model/login_request_model.dart';
import '../../models/login_response_model/login_response_model.dart';

abstract interface class RemoteLoginDataSource {
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel body);
}