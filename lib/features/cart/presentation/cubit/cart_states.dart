import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';

class CartState{
  final GetCartResponseEntity? getCartResponse;

  CartState({this.getCartResponse });

  CartState copyWith({GetCartResponseEntity? getCartResponse}) => CartState(getCartResponse: getCartResponse ?? this.getCartResponse);
}

