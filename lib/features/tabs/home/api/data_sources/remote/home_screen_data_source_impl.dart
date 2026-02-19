import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/tabs/home/api/api_clinet/home_screen_api_client.dart';
import 'package:flower_app/features/tabs/home/data/data_sources/remote/home_screen_data_source.dart';
import 'package:flower_app/features/tabs/home/data/models/home_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeScreenDataSource)
class HomeScreenDataSourceImpl implements HomeScreenDataSource {
  final HomeScreenApiClient homeScreenApiClient;
  HomeScreenDataSourceImpl(this.homeScreenApiClient);

  @override
  Future<BaseResponse<HomeResponseDto>> getHomeScreenData() async {
    return safeApiCall(() => homeScreenApiClient.getHomeScreenData());
  }
}
