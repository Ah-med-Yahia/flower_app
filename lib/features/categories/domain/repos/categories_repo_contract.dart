import '../../../../config/base_response/base_response.dart';
import '../entities/get_all_categories_list_entity.dart';
import '../entities/get_categories_products_entity.dart';

abstract interface class CategoriesRepoContract {
  Future<BaseResponse<GetCategoryListEntity>> getAllCategories();

  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts(
    String id,
  );
}
