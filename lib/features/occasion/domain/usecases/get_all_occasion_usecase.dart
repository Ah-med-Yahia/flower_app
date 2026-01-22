import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/repos/occasion_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllOccasionUsecase {
  final OccasionRepoContract _occasionRepoContract;
  GetAllOccasionUsecase(this._occasionRepoContract);
  Future<BaseResponse<GetAllOccasionEntity>> getAllOccasions() async {
    return await _occasionRepoContract.getAllOccasions();
  }
}
