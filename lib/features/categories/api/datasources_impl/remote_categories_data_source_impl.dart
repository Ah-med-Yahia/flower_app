import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/categories/api/api_service/categories_api_client.dart';
import 'package:flower_app/features/categories/data/datasources/remote_categories_data_source.dart';
import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/features/categories/data/models/get_products_models/category_products_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteCategoriesDataSource)
class RemoteCategoriesDataSourceImpl implements RemoteCategoriesDataSource {
  final CategoriesApiClient _apiClient;

  RemoteCategoriesDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<GetAllCategoriesResponseModel>> getAllCategories() {
    return safeApiCall<GetAllCategoriesResponseModel>(
      () => _apiClient.getAllCategories(),
    );
  }

  @override
  Future<BaseResponse<CategoryProductsResponseModel>> getCategoryProducts({
    required String categoryId,
  }) {
    return safeApiCall<CategoryProductsResponseModel>(
      () => _apiClient.getCategoryProducts(categoryId: categoryId),
    );
  }
}
