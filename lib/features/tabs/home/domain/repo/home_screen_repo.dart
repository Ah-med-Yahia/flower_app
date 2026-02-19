import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tabs/home/domain/entities/home_response_entity.dart';

abstract interface class HomeScreenRepo {
  Future<BaseResponse<HomeResponseEntity>> getHomeScreenData();
}
