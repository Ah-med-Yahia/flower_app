import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/entities/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';

abstract interface class CategoriesRepoContract {
  Future<BaseResponse<GetCategoryListEntity>> getAllCategories();

  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts(
    String id,
  );
}
