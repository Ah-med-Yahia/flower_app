import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tabs/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:flower_app/features/tabs/categories/domain/repos/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUsecase {
  final CategoriesRepo _categoriesRepoContract;

  GetAllCategoriesUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryListEntity>> call() async =>
      await _categoriesRepoContract.getAllCategories();
}
