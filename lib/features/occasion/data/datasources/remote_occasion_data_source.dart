import '../../../../config/base_response/base_response.dart';
import '../models/get_all_occassion_models/get_all_occasions_response_model.dart';
import '../models/get_occasion_products_models/get_occasion_products_response_model.dart';

abstract interface class RemoteOccasionDataSource {
  Future<BaseResponse<GetAllOccasionsResponseModel>> getAllOccasions();

  Future<BaseResponse<GetOccasionProductsResponseModel>> getOccasionProducts(
    String id,
  );
}
