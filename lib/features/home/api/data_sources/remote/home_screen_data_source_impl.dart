import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../../data/data_sources/remote/home_screen_data_source.dart';
import '../../../data/models/home_response_dto.dart';
import '../../api_clinet/home_screen_api_client.dart';

@Injectable(as: HomeScreenDataSource)
class HomeScreenDataSourceImpl implements HomeScreenDataSource {
  final HomeScreenApiClient homeScreenApiClient;

  HomeScreenDataSourceImpl(this.homeScreenApiClient);

  @override
  Future<BaseResponse<HomeResponseDto>> getHomeScreenData() async {
    return safeApiCall(() => homeScreenApiClient.getHomeScreenData());
  }
}
