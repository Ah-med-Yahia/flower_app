import '../../../../config/base_response/base_response.dart';
import '../entities/get_all_occasions_list_entity.dart';
import '../entities/get_occasion_products_entity.dart';

abstract interface class OccasionRepoContract {
  Future<BaseResponse<GetOccasionListEntity>> getAllOccasions();

  Future<BaseResponse<GetOccasionProductsEntity>> getOccasionProducts(
    String id,
  );
}
