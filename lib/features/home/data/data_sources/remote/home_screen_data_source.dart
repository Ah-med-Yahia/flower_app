import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';

abstract interface class HomeScreenDataSource {
  Future<BaseResponse<HomeResponseDto>> getHomeScreenData();
}
