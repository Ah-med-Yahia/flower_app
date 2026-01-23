import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/data/models/get_all_occassion_models/get_all_occasions_response_model.dart';

<<<<<<< HEAD
abstract class RemoteOccasionDataSource {
=======
abstract interface class RemoteOccasionDataSource {
>>>>>>> origin/feature/ocassion
  Future<BaseResponse<GetAllOccasionsResponseModel>> getAllOccasions();
}
