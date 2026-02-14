import 'dart:async';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/remove_item_from_cart_use_case.dart';
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
  final AddToCartUseCase _addToCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final GetCartUseCase _getCartUseCase;
  Timer? _debounce;

  Map<String, String> sortOptions = {
    AppTextConstants.lowesPrice: QueryParamsValues.lowestPrice,
    AppTextConstants.highPrice: QueryParamsValues.highestPrice,
    AppTextConstants.newest: QueryParamsValues.newest,
    AppTextConstants.oldest: QueryParamsValues.oldest,
    AppTextConstants.discount: QueryParamsValues.lowestPriceAfterDiscount,
  };

  CategoriesCubit(
    this._getAllCategoriesUseCase,
    this._getCategoryProductsUseCase,
    this._addToCartUseCase,
    this._removeItemFromCartUseCase,
    this._getCartUseCase,
  ) : super(
        CategoriesState(
          categoriesState: const BaseState<GetCategoryListEntity>(),
          categoryProductsState: const BaseState<GetCategoryProductsEntity>(),
          productsInCart: const BaseState<List<String>>(),
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
      case AddProductToCart():
        _addProductToCart(event.productId, event.quantity);
      case RemoveProductFromCart():
        _removeProductFromCart(event.productId);
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
    if (keyword != null) {
      _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 300), () async {
        await _fetchCategoryProducts(
          categoryId,
          sortOption: sortOption,
          keyword: keyword,
        );
      });

      return;
    }

    await _fetchCategoryProducts(
      categoryId,
      sortOption: sortOption,
      keyword: keyword,
    );
  }

  Future<void> _fetchCategoryProducts(
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

    final cartProducts = await _getCartUseCase();

    categoryProducts.when(
      success: (data) {
        cartProducts.when(
          success: (cartData) => emit(
            state.copyWith(
              categoryProductsState: BaseState<GetCategoryProductsEntity>(
                data: data,
                isLoading: false,
              ),
              productsInCart: BaseState<List<String>>(
                data: cartData.cart.cartItems
                    .map((item) => item.product.productId)
                    .toList(),
              ),
            ),
          ),
          failure: (error) => emit(
            state.copyWith(
              categoryProductsState: BaseState<GetCategoryProductsEntity>(
                data: data,
                isLoading: false,
              ),
              productsInCart: BaseState<List<String>>(
                errorMessage: error.errorModel.message,
              ),
            ),
          ),
        );
      },
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

  Future<void> _addProductToCart(String productId, int quantity) async {
    emit(state.copyWith(pendingCartIds: [...state.pendingCartIds, productId]));

    final addToCart = await _addToCartUseCase(
      requestEntity: AddToCartRequestEntity(
        productId: productId,
        quantity: quantity,
      ),
    );

    addToCart.when(
      success: (data) => emit(
        state.copyWith(
          productsInCart: BaseState<List<String>>(
            data: data.cart.cartItems
                .map((item) => item.product.productId)
                .toList(),
          ),
          pendingCartIds: state.pendingCartIds
              .where((id) => id != productId)
              .toList(),
        ),
      ),
      failure: (error) {
        emit(
          state.copyWith(
            productsInCart: BaseState<List<String>>(
              errorMessage: error.errorModel.message,
            ),
            pendingCartIds: state.pendingCartIds
                .where((id) => id != productId)
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _removeProductFromCart(String productId) async {
    emit(state.copyWith(pendingCartIds: [...state.pendingCartIds, productId]));

    final removeFromCart = await _removeItemFromCartUseCase(
      productId: productId,
    );

    removeFromCart.when(
      success: (data) => emit(
        state.copyWith(
          productsInCart: BaseState<List<String>>(
            data: data.cart.cartItems
                .map((item) => item.product.productId)
                .toList(),
          ),
          pendingCartIds: state.pendingCartIds
              .where((id) => id != productId)
              .toList(),
        ),
      ),
      failure: (error) {
        emit(
          state.copyWith(
            productsInCart: BaseState<List<String>>(
              errorMessage: error.errorModel.message,
            ),
            pendingCartIds: state.pendingCartIds
                .where((id) => id != productId)
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
