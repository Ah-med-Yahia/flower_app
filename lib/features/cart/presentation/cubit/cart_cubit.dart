import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flower_app/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/clear_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/get_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/remove_item_from_cart_use_case.dart';
import 'package:flower_app/features/cart/domain/usecases/update_item_quantity_use_case.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_event_ui.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_intents.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase _addToCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final GetCartUseCase _getCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final UpdateItemQuantityUseCase _updateItemQuantityUseCase;

  CartCubit(
    this._addToCartUseCase,
    this._clearCartUseCase,
    this._getCartUseCase,
    this._removeItemFromCartUseCase,
    this._updateItemQuantityUseCase,
  ) : super(CartState());

  final _uiEventController = StreamController<CartEventUI>.broadcast();
  Stream<CartEventUI> get uiEvents => _uiEventController.stream;

  Future<void> doIntent(CartIntents intent) async {
    switch (intent) {
      case GetCartIntent():
        _getCart();
      case AddToCartIntent(:final requestEntity):
        _addToCart(requestEntity);
      case UpdateItemQuantityIntent(:final productId, :final requestEntity):
        _updateItemQuantity(productId, requestEntity);
      case RemoveItemFromCartIntent(:final productId):
        _removeItemFromCart(productId);
      case ClearCartIntent():
        _clearCart();
    }
  }

  Future<void> _getCart() async {
    _uiEventController.add(LoadingCart());
    final response = await _getCartUseCase();
    response.when(
      success: (success) {
        emit(state.copyWith(getCartResponse: success));
      },
      failure: (failure) {
        _uiEventController.add(Error(message: failure.message));
      },
    );
  }

  Future<void> _addToCart(AddToCartRequestEntity requestEntity) async {
    _uiEventController.add(AddingToCart());
    final response = await _addToCartUseCase(requestEntity: requestEntity);
    response.when(
      success: (success) {
        emit(state.copyWith(getCartResponse: success));
      },
      failure: (failure) {
        _uiEventController.add(Error(message: failure.message));
      },
    );
  }

  Future<void> _updateItemQuantity(
    String productId,
    UpdateItemQuantityRequestEntity requestEntity,
  ) async {
    final response = await _updateItemQuantityUseCase(
      productId: productId,
      requestEntity: requestEntity,
    );
    response.when(
      success: (success) {
        emit(state.copyWith(getCartResponse: success));
      },
      failure: (failure) {
        _uiEventController.add(Error(message: failure.message));
      },
    );
  }

  Future<void> _removeItemFromCart(String productId) async {
    final response = await _removeItemFromCartUseCase(productId: productId);
    response.when(
      success: (success) {
        emit(state.copyWith(getCartResponse: success));
      },
      failure: (failure) {
        _uiEventController.add(Error(message: failure.message));
      },
    );
  }

  Future<void> _clearCart() async {
    _uiEventController.add(LoadingCart());
    final response = await _clearCartUseCase();
    response.when(
      success: (success) {
        emit(state.copyWith(getCartResponse: null));
        _uiEventController.add(SuccessClearCart(message: success.message));
      },
      failure: (failure) {
        _uiEventController.add(Error(message: failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
