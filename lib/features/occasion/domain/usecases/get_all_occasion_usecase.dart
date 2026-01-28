import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/get_all_occasions_list_entity.dart';
import '../repos/occasion_repo_contract.dart';

@injectable
class GetAllOccasionUsecase {
  final OccasionRepoContract _occasionRepoContract;

  GetAllOccasionUsecase(this._occasionRepoContract);

  Future<BaseResponse<GetOccasionListEntity>> getAllOccasions() async {
    return await _occasionRepoContract.getAllOccasions();
  }
}
