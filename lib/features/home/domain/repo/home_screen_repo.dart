import '../../../../config/base_response/base_response.dart';
import '../entities/home_response_entity.dart';

abstract interface class HomeScreenRepo {
  Future<BaseResponse<HomeResponseEntity>> getHomeScreenData();
}
