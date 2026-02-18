import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared/data/mappers/products_response_mapper.dart';
import 'package:flower_app/features/categories/data/datasources/remote_categories_data_source.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final RemoteCategoriesDataSource _categoriesDataSource;

  CategoriesRepoImpl(this._categoriesDataSource);

  @override
  Future<BaseResponse<GetCategoryListEntity>> getAllCategories() async {
    final response = await _categoriesDataSource.getAllCategories();
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }

  @override
  Future<BaseResponse<ProductsResponseEntity>> getCategoryProducts({
    required String categoryId,
    String? sortOption,
    String? keyword,
  }) async {
    final response = await _categoriesDataSource.getCategoryProducts(
      categoryId: categoryId,
      sortOption: sortOption,
      keyword: keyword,
    );
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }
}
