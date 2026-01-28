import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/get_occasion_products_entity.dart';
import '../repos/occasion_repo_contract.dart';

@injectable
class GetOccasionProductsUsecase {
  final OccasionRepoContract _occasionRepoContract;

  GetOccasionProductsUsecase(this._occasionRepoContract);

  Future<BaseResponse<GetOccasionProductsEntity>> getOccasionProducts(
    String occasionId,
  ) async {
    return await _occasionRepoContract.getOccasionProducts(occasionId);
  }
}
