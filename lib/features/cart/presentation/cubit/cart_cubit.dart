import 'dart:async';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
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
  final ClearCartUseCase _clearCartUseCase;
  final GetCartUseCase _getCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final UpdateItemQuantityUseCase _updateItemQuantityUseCase;

  CartCubit(
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
        _uiEventController.add(SuccessAfterLoading());
        success.numOfCartItems == 0
            ? emit(
                state.copyWith(
                  cartBaseState: CartBaseState<GetCartResponseEntity>(
                    isEmpty: true,
                    data: success,
                  ),
                ),
              )
            : emit(
                state.copyWith(
                  cartBaseState: CartBaseState<GetCartResponseEntity>(
                    data: success,
                  ),
                ),
              );
      },
      failure: (failure) {
        _uiEventController.add(ErrorGetCart(message: failure.message));
        emit(
          state.copyWith(
            cartBaseState: const CartBaseState<GetCartResponseEntity>(
              isError: true,
            ),
          ),
        );
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
        emit(
          state.copyWith(
            cartBaseState: CartBaseState<GetCartResponseEntity>(data: success),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            cartBaseState: CartBaseState<GetCartResponseEntity>(
              data: state.cartBaseState?.data,
            ),
          ),
        );
        _uiEventController.add(ErrorCartItemsUpdate(message: failure.message));
      },
    );
  }

  Future<void> _removeItemFromCart(String productId) async {
    final response = await _removeItemFromCartUseCase(productId: productId);
    response.when(
      success: (success) {
        success.numOfCartItems == 0
            ? emit(
                state.copyWith(
                  cartBaseState: CartBaseState<GetCartResponseEntity>(
                    isEmpty: true,
                    data: success,
                  ),
                ),
              )
            : emit(
                state.copyWith(
                  cartBaseState: CartBaseState<GetCartResponseEntity>(
                    data: success,
                  ),
                ),
              );
      },
      failure: (failure) {
        final previousResponse = state.cartBaseState?.data;
        if (previousResponse != null) {
          final updatedItems = previousResponse.cart.cartItems.map((item) {
            return item.copyWith();
          }).toList();
          final updatedData = previousResponse.copyWith(
            cart: previousResponse.cart.copyWith(cartItems: updatedItems),
          );
          emit(
            state.copyWith(
              cartBaseState: CartBaseState<GetCartResponseEntity>(
                data: updatedData,
              ),
            ),
          );
        }
        _uiEventController.add(ErrorCartItemsUpdate(message: failure.message));
      },
    );
  }

  Future<void> _clearCart() async {
    _uiEventController.add(LoadingCart());
    final response = await _clearCartUseCase();
    response.when(
      success: (success) {
        _uiEventController.add(SuccessAfterLoading(message: success.message));
        emit(
          state.copyWith(
            cartBaseState: const CartBaseState<GetCartResponseEntity>(
              isEmpty: true,
            ),
          ),
        );
      },
      failure: (failure) {
        _uiEventController.add(ErrorGetCart(message: failure.message));
        emit(
          state.copyWith(
            cartBaseState: const CartBaseState<GetCartResponseEntity>(
              isError: true,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
