import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';

abstract class OccasionDataSourceContract {
  Future<BaseResponse<GetAllOccasionsResponseModel>> getAllOccasions();
}
