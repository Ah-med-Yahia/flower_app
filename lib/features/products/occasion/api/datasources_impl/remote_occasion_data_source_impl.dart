import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/products/occasion/api/api_client/occasion_api_client.dart';
import 'package:flower_app/features/products/occasion/data/datasources/remote_occasion_data_source.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import 'package:flower_app/features/products/occasion/data/models/get_occasion_products_models/get_occasion_products_response_model.dart';

@Injectable(as: RemoteOccasionDataSource)
class RemoteOccasionDataSourceImpl implements RemoteOccasionDataSource {
  final OccasionApiClient _apiClient;

  RemoteOccasionDataSourceImpl(this._apiClient);

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
