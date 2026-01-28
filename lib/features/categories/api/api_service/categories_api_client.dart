import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../data/models/get_all_categories_models/get_all_categories_response_model.dart';
import '../../data/models/get_products_models/category_product_response.dart';

part 'categories_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(ApiConstants.getAllCategories)
  Future<GetAllCategoriesResponseModel> getAllCategories();

  @GET(ApiConstants.getCategoryProducts)
  Future<CategoryProductResponse> getCategoryProducts({
    @Path('id') required String id,
  });
}
