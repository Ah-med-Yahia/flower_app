import 'package:flower_app/features/categories/domain/entities/get_all_categories_list_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:flower_app/features/categories/presentation/view_model/categories_event.dart';
import 'package:flower_app/features/categories/presentation/view_model/categories_state.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetAllCategoriesUsecase _getAllCategoriesUsecase;
  final GetCategoryProductsUsecase _getCategoryProductsUsecase;

  CategoriesCubit(
    this._getAllCategoriesUsecase,
    this._getCategoryProductsUsecase,
  ) : super(
        CategoriesState(
          categoriesState: BaseState<GetCategoryListEntity>(),
          categoryProductsState: BaseState<GetCategoryProductsEntity>(),
          selectedIndex: 0,
        ),
      );

  void onEvent(CategoriesEvent event) {
    switch (event) {
      case GetAllCategories():
        _getAllCategories(event.initialCategoryId);
      case SelectCategory():
        _selectCategory(event.index);
      case GetCategoryProducts():
        _getCategoryProducts(event.categoryId);
    }
  }

  Future<void> _getAllCategories(String? initialCategoryId) async {
    emit(
      state.copyWith(
        categoriesState: BaseState<GetCategoryListEntity>(isLoading: true),
      ),
    );

    final categories = await _getAllCategoriesUsecase.getAllCategories();

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
            selectedIndex: selectedIndex,
          ),
        );
        final occasionsList = data.categories ?? [];

        if (occasionsList.isNotEmpty) {
          final occasionId = occasionsList[selectedIndex].id;
          if (occasionId != null) {
            _getCategoryProducts(occasionId);
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
    emit(state.copyWith(selectedIndex: index));

    final categories = state.categoriesState.data?.categories ?? [];

    if (index < categories.length) {
      final categoryId = categories[index].id;

      if (categoryId != null) {
        _getCategoryProducts(categoryId);
      }
    }
  }

  Future<void> _getCategoryProducts(String categoryId) async {
    emit(
      state.copyWith(
        categoryProductsState: BaseState<GetCategoryProductsEntity>(
          isLoading: true,
        ),
      ),
    );

    final categoryProducts = await _getCategoryProductsUsecase
        .getCategoryProducts(categoryId);

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
}
