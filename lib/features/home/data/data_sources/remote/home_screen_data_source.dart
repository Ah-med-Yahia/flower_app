import '../../../../../config/base_response/base_response.dart';
import '../../models/home_response_dto.dart';

abstract interface class HomeScreenDataSource {
  Future<BaseResponse<HomeResponseDto>> getHomeScreenData();
}
