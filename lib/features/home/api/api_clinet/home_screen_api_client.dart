import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants.dart';
import '../../data/models/home_response_dto.dart';

part 'home_screen_api_client.g.dart';

@RestApi()
@injectable
abstract class HomeScreenApiClient {
  @factoryMethod
  factory HomeScreenApiClient(Dio dio) = _HomeScreenApiClient;

  @GET(ApiConstants.homeScreenEndPoint)
  Future<HomeResponseDto> getHomeScreenData();
}
