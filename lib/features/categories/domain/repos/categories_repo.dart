import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';

abstract interface class CategoriesRepo {
  Future<BaseResponse<GetCategoryListEntity>> getAllCategories();

  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts({
    required String categoryId,
    String? sortOption,
    String? keyword,
  });
}
