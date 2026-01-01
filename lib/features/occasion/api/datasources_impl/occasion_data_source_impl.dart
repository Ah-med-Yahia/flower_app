import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/network/safe_api_call.dart';
import 'package:online_exam_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:online_exam_app/features/occasion/data/datasources/occasion_data_source_contract.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response.dart';

@LazySingleton(as: OccasionDataSourceContract)
class OccasionRemoteDataSourceImpl implements OccasionDataSourceContract {
  final OccasionApiClient _apiClient;

  OccasionRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<GetAllOccasionsResponse>> getAllOccasions() {
    return safeApiCall<GetAllOccasionsResponse>(
      () => _apiClient.getallOcassions(),
    );
  }
}
