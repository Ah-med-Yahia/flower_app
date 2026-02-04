import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_products_usecase.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_intents.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUsecase _getAllCategoriesUseCase;
  final GetCategoryProductsUsecase _getCategoryProductsUseCase;

  Map<String, String> sortOptions = {
    AppTextConstants.lowesPrice: 'price',
    AppTextConstants.highPrice: '-price',
    AppTextConstants.newest: '-createdAt',
    AppTextConstants.oldest: 'createdAt',
    AppTextConstants.discount: 'priceAfterDiscount',
  };

  CategoriesCubit(
    this._getAllCategoriesUseCase,
    this._getCategoryProductsUseCase,
  ) : super(
        CategoriesState(
          categoriesState: const BaseState<GetCategoryListEntity>(),
          categoryProductsState: const BaseState<GetCategoryProductsEntity>(),
          selectedIndexCategoryBar: 0,
        ),
      );

  void onIntent(CategoriesIntents event) {
    switch (event) {
      case GetAllCategories():
        _getAllCategories(event.initialCategoryId);
      case SelectCategory():
        _selectCategory(event.index);
      case GetCategoryProducts():
        _getCategoryProducts(
          event.categoryId,
          sortOption: event.sortOption,
          keyword: event.keyword,
        );
      case SelectSortOption():
        _selectSortOption(event.sortOption);
      case IsSearching():
        _isSearching();
    }
  }

  Future<void> _getAllCategories(String? initialCategoryId) async {
    emit(
      state.copyWith(
        categoriesState: const BaseState<GetCategoryListEntity>(
          isLoading: true,
        ),
      ),
    );

    final categories = await _getAllCategoriesUseCase();

    categories.when(
      success: (data) {
        int selectedIndex = 0;
        if (data.categories != null && data.categories!.isNotEmpty) {
          if (initialCategoryId != null) {
            final index = data.categories!.indexWhere(
              (occasion) => occasion.id == initialCategoryId,
            );

            if (index != -1) {
              selectedIndex = index;
            } else {
              selectedIndex = 0;
            }
          } else {
            selectedIndex = 0;
          }
        }

        emit(
          state.copyWith(
            categoriesState: BaseState<GetCategoryListEntity>(
              data: data,
              isLoading: false,
            ),
            selectedIndexCategoryBar: selectedIndex,
          ),
        );
        final categoriesList = data.categories ?? [];

        if (categoriesList.isNotEmpty) {
          final categoryId = categoriesList[selectedIndex].id;
          if (categoryId != null) {
            _getCategoryProducts(categoryId);
          }
        }
      },
      failure: (error) => emit(
        state.copyWith(
          categoriesState: BaseState<GetCategoryListEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  void _selectCategory(int index) {
    emit(state.copyWith(selectedIndexCategoryBar: index));

    final categories = state.categoriesState.data?.categories ?? [];

    if (index < categories.length) {
      final categoryId = categories[index].id;

      if (categoryId != null) {
        _getCategoryProducts(categoryId);
      }
    }
  }

  Future<void> _getCategoryProducts(
    String categoryId, {
    String? sortOption,
    String? keyword,
  }) async {
    emit(
      state.copyWith(
        categoryProductsState: const BaseState<GetCategoryProductsEntity>(
          isLoading: true,
        ),
        categoryId: categoryId,
        selectedSortOption: sortOption,
      ),
    );

    final categoryProducts = await _getCategoryProductsUseCase(
      categoryId: categoryId,
      sortOption: sortOption,
      keyword: keyword,
    );

    categoryProducts.when(
      success: (data) => emit(
        state.copyWith(
          categoryProductsState: BaseState<GetCategoryProductsEntity>(
            data: data,
            isLoading: false,
          ),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          categoryProductsState: BaseState<GetCategoryProductsEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  void _selectSortOption(String? sortOption) {
    emit(state.copyWith(selectedSortOption: sortOption));
  }

  void _isSearching() {
    emit(state.copyWith(isSearching: !state.isSearching));
  }
}
