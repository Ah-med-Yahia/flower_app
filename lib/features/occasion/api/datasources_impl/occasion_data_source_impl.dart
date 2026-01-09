import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/network/safe_api_call.dart';
import 'package:online_exam_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:online_exam_app/features/occasion/data/datasources/occasion_data_source_contract.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_occasion_products_models/get_occasion_products_response_model.dart';

@LazySingleton(as: OccasionDataSourceContract)
class OccasionDataSourceImpl implements OccasionDataSourceContract {
  final OccasionApiClient _apiClient;

  OccasionDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<GetAllOccasionsResponseModel>> getAllOccasions() {
    return safeApiCall<GetAllOccasionsResponseModel>(
      () => _apiClient.getallOcassions(),
    );
  }

  @override
  Future<BaseResponse<GetOccasionProductsResponseModel>> getOccasionProducts(
    String id,
  ) {
    return safeApiCall<GetOccasionProductsResponseModel>(
      () => _apiClient.getOccasionProducts(id: id),
    );
  }
}
