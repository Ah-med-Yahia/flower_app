import 'package:flower_app/config/base_response/base_response.dart';

abstract interface class SplashLocalDataSource {
  Future<BaseResponse<bool>> isLogged();
}
