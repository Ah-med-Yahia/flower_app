import 'package:flower_app/config/base_response/base_response.dart';

abstract interface class SplashRepo {
  Future<BaseResponse<bool>> isLogged();
}
