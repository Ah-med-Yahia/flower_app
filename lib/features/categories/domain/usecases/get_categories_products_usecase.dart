import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/get_categories_products_entity.dart';
import '../repos/categories_repo_contract.dart';

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
