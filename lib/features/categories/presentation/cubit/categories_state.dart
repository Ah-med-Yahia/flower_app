import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';

class CategoriesState {
  final BaseState<GetCategoryListEntity> categoriesState;
  final BaseState<GetCategoryProductsEntity> categoryProductsState;
  final int selectedIndexCategoryBar;
  final String? selectedSortOption;
  final String? categoryId;
  final bool isSearching;

  CategoriesState({
    required this.categoriesState,
    this.selectedIndexCategoryBar = 0,
    required this.categoryProductsState,
    this.selectedSortOption,
    this.categoryId,
    this.isSearching = false,
  });

  CategoriesState copyWith({
    BaseState<GetCategoryListEntity>? categoriesState,
    int? selectedIndexCategoryBar,
    String? selectedSortOption,
    BaseState<GetCategoryProductsEntity>? categoryProductsState,
    String? categoryId,
    bool? isSearching,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedIndexCategoryBar:
          selectedIndexCategoryBar ?? this.selectedIndexCategoryBar,
      selectedSortOption: selectedSortOption,
      categoryProductsState:
          categoryProductsState ?? this.categoryProductsState,
      categoryId: categoryId ?? this.categoryId,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
