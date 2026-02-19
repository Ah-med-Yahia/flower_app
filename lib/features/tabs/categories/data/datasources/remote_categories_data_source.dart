import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tabs/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';

abstract interface class RemoteCategoriesDataSource {
  Future<BaseResponse<GetAllCategoriesResponseModel>> getAllCategories();
}
