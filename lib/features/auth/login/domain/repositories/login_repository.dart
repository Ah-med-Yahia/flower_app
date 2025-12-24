import '../../../../../config/base_response/base_response.dart';
import '../entities/login_request_entity.dart';

abstract class LoginRepository {
  Future<BaseResponse<void>> login(LoginRequestEntity request);
}