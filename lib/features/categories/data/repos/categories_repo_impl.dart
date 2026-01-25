import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/data/datasources/remote_categories_data_source.dart';
import 'package:flower_app/features/categories/domain/entities/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo_contract.dart';

@Injectable(as: CategoriesRepoContract)
class CategoriesRepoImpl implements CategoriesRepoContract {
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
  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts(
    String id,
  ) async {
    final response = await _categoriesDataSourceContract.getCategoryProducts(
      id,
    );
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }
}
