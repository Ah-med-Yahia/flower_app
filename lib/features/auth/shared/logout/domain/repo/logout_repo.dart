import '../../../../../../config/base_response/base_response.dart';

abstract class LogoutRepo {
  Future<BaseResponse<void>> clearUserTokens();
}
