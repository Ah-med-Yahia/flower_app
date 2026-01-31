import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/features/categories/data/models/get_products_models/category_product_response.dart';

abstract interface class RemoteCategoriesDataSource {
  Future<BaseResponse<GetAllCategoriesResponseModel>> getAllCategories();

  Future<BaseResponse<CategoryProductResponse>> getCategoryProducts(String id);
}
