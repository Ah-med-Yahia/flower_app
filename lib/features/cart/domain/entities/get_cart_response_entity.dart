import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_entity.dart';

class GetCartResponseEntity extends Equatable {
  final String message;
  final int numOfCartItems;
  final CartEntity cart;

  const GetCartResponseEntity({
    required this.message,
    required this.numOfCartItems,
    required this.cart,
  });

  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}
