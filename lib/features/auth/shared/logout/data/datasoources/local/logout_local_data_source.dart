import '../../../../../../../config/base_response/base_response.dart';

abstract class LogoutLocalDataSource {
  Future<BaseResponse<void>> clearUserTokens();
}
