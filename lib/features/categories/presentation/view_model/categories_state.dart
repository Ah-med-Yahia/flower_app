import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/categories/domain/entities/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';

class CategoriesState {
  final BaseState<GetCategoryListEntity> categoriesState;
  final BaseState<GetCategoryProductsEntity> categoryProductsState;
  final int selectedIndex;

  CategoriesState({
    required this.categoriesState,
    this.selectedIndex = 0,
    required this.categoryProductsState,
  });

  CategoriesState copyWith({
    BaseState<GetCategoryListEntity>? categoriesState,
    int? selectedIndex,
    BaseState<GetCategoryProductsEntity>? categoryProductsState,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categoryProductsState:
          categoryProductsState ?? this.categoryProductsState,
    );
  }
}
