import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/features/categories/data/models/get_products_models/category_products_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(ApiConstants.getAllCategories)
  Future<GetAllCategoriesResponseModel> getAllCategories();

  @GET(ApiConstants.getCategoryProducts)
  Future<CategoryProductsResponseModel> getCategoryProducts({
    @Query(QueryParamsKey.categoryId) required String categoryId,
    @Query(QueryParamsKey.sort) String? sortOption,
    @Query(QueryParamsKey.search) String? keyword,
  });
}
