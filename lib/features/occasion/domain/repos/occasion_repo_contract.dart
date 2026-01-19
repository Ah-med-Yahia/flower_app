import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';

abstract class OccasionRepoContract {
  Future<BaseResponse<GetAllOccasionEntity>> getAllOccasions();
  Future<BaseResponse<GetOccasionProductsEntity>> getOccasionProducts(
    String id,
  );
}
