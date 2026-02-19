import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/tabs/categories/api/api_service/categories_api_client.dart';
import 'package:flower_app/features/tabs/categories/data/datasources/remote_categories_data_source.dart';
import 'package:flower_app/features/tabs/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
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
}
