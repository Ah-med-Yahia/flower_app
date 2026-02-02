import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';

class CartState {
  final CartBaseState<GetCartResponseEntity>? cartBaseState;

  CartState({this.cartBaseState});

  CartState copyWith({CartBaseState<GetCartResponseEntity>? cartBaseState}) {
    return CartState(cartBaseState: cartBaseState ?? this.cartBaseState);
  }
}
