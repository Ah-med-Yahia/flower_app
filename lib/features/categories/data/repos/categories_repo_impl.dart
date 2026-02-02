import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/data/datasources/remote_categories_data_source.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final RemoteCategoriesDataSource _categoriesDataSourceContract;

  CategoriesRepoImpl(this._categoriesDataSourceContract);

  @override
  Future<BaseResponse<GetCategoryListEntity>> getAllCategories() async {
    final response = await _categoriesDataSourceContract.getAllCategories();
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }

  @override
  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts({
    required String categoryId,
  }) async {
    final response = await _categoriesDataSourceContract.getCategoryProducts(
      categoryId: categoryId,
    );
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }
}
