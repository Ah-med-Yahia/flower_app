import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/use_cases.dart/get_products_use_cases.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_intents.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_side_effect.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_state.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower_app/features/tabs/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
    this._addToCartUseCase,
    this._removeItemFromCartUseCase,
    this._getCartUseCase,
    this._getProductsUseCase,
  ) : super(
        ProductsState(
          productsInCart: const BaseState<List<String>>(),
          productsState: const BaseState<ProductsResponseEntity>(),
        ),
      );

  final AddToCartUseCase _addToCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final GetCartUseCase _getCartUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final StreamController<ProductsSideEffect> _sideEffectController =
      StreamController<ProductsSideEffect>.broadcast();
  Stream<ProductsSideEffect> get sideEffectStream =>
      _sideEffectController.stream;

  void onIntent(ProductsIntents intent) {
    switch (intent) {
      case GetProducts():
        _fetchProducts(
          intent.categoryId,
          sortOption: intent.sortOption,
          keyword: intent.keyword,
          occasionId: intent.occasionId,
        );
      case UpdateCart():
        _updateCart();
      case AddProductToCart():
        _addProductToCart(intent.productId, intent.quantity);
      case RemoveProductFromCart():
        _removeProductFromCart(intent.productId);
      case IsSearching():
        _isSearching(intent.isSearching);
      case ResetProductsAfterSearch():
        _resetProductsAfterSearch();
    }
  }

  Future<void> _fetchProducts(
    String? categoryId, {
    String? sortOption,
    String? keyword,
    String? occasionId,
  }) async {
    emit(
      state.copyWith(
        productsState: const BaseState<ProductsResponseEntity>(isLoading: true),
      ),
    );

    final products = await _getProductsUseCase(
      categoryId: categoryId,
      sortOption: sortOption,
      keyword: keyword,
      occasionId: occasionId,
    );

    final cartProducts = await _getCartUseCase();

    products.when(
      success: (data) {
        cartProducts.when(
          success: (cartData) => emit(
            state.copyWith(
              productsState: BaseState<ProductsResponseEntity>(
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
              productsState: BaseState<ProductsResponseEntity>(
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
          productsState: BaseState<ProductsResponseEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  Future<void> _updateCart() async {
    final response = await _getCartUseCase();

    response.when(
      success: (data) => emit(
        state.copyWith(
          productsInCart: BaseState<List<String>>(
            data: data.cart.cartItems
                .map((item) => item.product.productId)
                .toList(),
          ),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          productsInCart: BaseState<List<String>>(
            errorMessage: error.errorModel.message,
          ),
        ),
      ),
    );
  }

  Future<void> _isSearching(bool isSearching) async {
    isSearching
        ? emit(state.copyWith(isSearching: isSearching))
        : emit(
            state.copyWith(
              isSearching: isSearching,
              productsState: const BaseState<ProductsResponseEntity>(
                data: null,
                isLoading: false,
                errorMessage: null,
              ),
            ),
          );
  }

  Future<void> _resetProductsAfterSearch() async {
    emit(
      state.copyWith(
        productsState: const BaseState<ProductsResponseEntity>(
          data: null,
          isLoading: false,
          errorMessage: null,
        ),
      ),
    );
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
        if (error.errorModel.code == 401) {
          _sideEffectController.add(LogoutUser());
        }
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
    _sideEffectController.close();
    return super.close();
  }
}
