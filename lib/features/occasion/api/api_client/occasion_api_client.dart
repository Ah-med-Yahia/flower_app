import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_text_constants.dart';
import '../../data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import '../../data/models/get_occasion_products_models/get_occasion_products_response_model.dart';

part 'occasion_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class OccasionApiClient {
  @factoryMethod
  factory OccasionApiClient(Dio dio) = _OccasionApiClient;

  @GET(ApiConstants.getAllOccasions)
  Future<GetAllOccasionsResponseModel> getallOcassions();

  @GET(ApiConstants.getOccasionProducts)
  Future<GetOccasionProductsResponseModel> getOccasionProducts({
    @Path(AppTextConstants.id) required String id,
  });
}
