import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/get_all_categories_list_entity.dart';
import '../repos/categories_repo_contract.dart';

@injectable
class GetAllCategoriesUsecase {
  final CategoriesRepoContract _categoriesRepoContract;

  GetAllCategoriesUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryListEntity>> getAllCategories() async {
    return await _categoriesRepoContract.getAllCategories();
  }
}
