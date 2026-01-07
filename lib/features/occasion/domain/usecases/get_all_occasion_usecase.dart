import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:online_exam_app/features/occasion/domain/repos/occasion_repo_contract.dart';

@injectable
class GetAllOccasionUsecase {
  OccasionRepoContract occasionRepoContract;
  GetAllOccasionUsecase({required this.occasionRepoContract});
  Future<BaseResponse<GetAllOccasionEntity>> getAllOccasions() async {
    return await occasionRepoContract.getAllOccasions();
  }
}
