import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/network/safe_api_call.dart';
import '../../data/datasources/remote_categories_data_source.dart';
import '../../data/models/get_all_categories_models/get_all_categories_response_model.dart';
import '../../data/models/get_products_models/category_product_response.dart';
import '../api_service/categories_api_client.dart';

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
  Future<BaseResponse<CategoryProductResponse>> getCategoryProducts(String id) {
    return safeApiCall<CategoryProductResponse>(
      () => _apiClient.getCategoryProducts(id: id),
    );
  }
}
