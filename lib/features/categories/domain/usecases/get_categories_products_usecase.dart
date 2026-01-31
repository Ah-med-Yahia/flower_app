import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryProductsUsecase {
  final CategoriesRepoContract _categoriesRepoContract;

  GetCategoryProductsUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts(
    String categoryId,
  ) async {
    return await _categoriesRepoContract.getCategoryProducts(categoryId);
  }
}
