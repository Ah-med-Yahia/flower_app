import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';

class CategoriesState {
  final BaseState<GetCategoryListEntity> categoriesState;
  final BaseState<ProductsResponseEntity> categoryProductsState;
  final BaseState<List<String>> productsInCart;
  final List<String> pendingCartIds;
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
    required this.productsInCart,
    this.pendingCartIds = const [],
  });

  CategoriesState copyWith({
    BaseState<GetCategoryListEntity>? categoriesState,
    int? selectedIndexCategoryBar,
    String? selectedSortOption,
    BaseState<ProductsResponseEntity>? categoryProductsState,
    String? categoryId,
    bool? isSearching,
    BaseState<List<String>>? productsInCart,
    List<String>? pendingCartIds,
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
      productsInCart: productsInCart ?? this.productsInCart,
      pendingCartIds: pendingCartIds ?? this.pendingCartIds,
    );
  }
}
