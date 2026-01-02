import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/constants/api_constants.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'occasion_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class OccasionApiClient {
  @factoryMethod
  factory OccasionApiClient(Dio dio) = _OccasionApiClient;

  @GET(ApiConstants.getAllOccasions)
  Future<GetAllOccasionsResponseModel> getallOcassions();
}
