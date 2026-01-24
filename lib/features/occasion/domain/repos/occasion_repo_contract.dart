import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasions_list_entity.dart';

abstract interface class OccasionRepoContract {
  Future<BaseResponse<GetOccasionListEntity>> getAllOccasions();
}
