import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/entities/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUsecase {
  final CategoriesRepoContract _categoriesRepoContract;
  GetAllCategoriesUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryListEntity>> getAllCategories() async {
    return await _categoriesRepoContract.getAllCategories();
  }
}
