import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/features/tabs/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required BaseState<GetCategoryListEntity> categoriesState,
    required BaseState<ProductsResponseEntity> categoryProductsState,
    required BaseState<List<String>> productsInCart,
    @Default([]) List<String> pendingCartIds,
    @Default(0) int selectedIndexCategoryBar,
    String? selectedSortOption,
    String? categoryId,
    @Default(false) bool isSearching,
  }) = _CategoriesState;
}
