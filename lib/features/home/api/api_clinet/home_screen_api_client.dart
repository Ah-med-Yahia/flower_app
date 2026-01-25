import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'home_screen_api_client.g.dart';

@RestApi()
@injectable
abstract class HomeScreenApiClient {
  @factoryMethod
  factory HomeScreenApiClient(Dio dio) = _HomeScreenApiClient;

  @GET(ApiConstants.homeScreenEndPoint)
  Future<HomeResponseDto> getHomeScreenData();
}
