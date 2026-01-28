import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/network/safe_api_call.dart';
import '../../data/datasources/remote_occasion_data_source.dart';
import '../../data/models/get_all_occassion_models/get_all_occasions_response_model.dart';
import '../../data/models/get_occasion_products_models/get_occasion_products_response_model.dart';
import '../api_client/occasion_api_client.dart';

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
