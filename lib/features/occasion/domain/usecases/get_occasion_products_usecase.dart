import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:online_exam_app/features/occasion/domain/repos/occasion_repo_contract.dart';

@injectable
class GetOccasionProductsUsecase {
  final OccasionRepoContract occasionRepoContract;
  GetOccasionProductsUsecase({required this.occasionRepoContract});
  Future<BaseResponse<GetOccasionProductsEntity>> getOccasionProducts(
    String occasionId,
  ) async {
    return await occasionRepoContract.getOccasionProducts(occasionId);
  }
}
