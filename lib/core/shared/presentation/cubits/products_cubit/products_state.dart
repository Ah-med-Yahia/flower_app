import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';

class ProductsState {
  final BaseState<ProductsResponseEntity> productsState;
  final BaseState<List<String>> productsInCart;
  final List<String> pendingCartIds;
  final bool isSearching;

  ProductsState({
    required this.productsState,
    this.pendingCartIds = const [],
    required this.productsInCart,
    this.isSearching = false,
  });

  ProductsState copyWith({
    BaseState<ProductsResponseEntity>? productsState,
    BaseState<List<String>>? productsInCart,
    List<String>? pendingCartIds,
    bool? isSearching,
  }) {
    return ProductsState(
      productsState: productsState ?? this.productsState,
      productsInCart: productsInCart ?? this.productsInCart,
      pendingCartIds: pendingCartIds ?? this.pendingCartIds,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
