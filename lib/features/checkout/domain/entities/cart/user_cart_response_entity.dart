import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';

class UserCartResponseEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const UserCartResponseEntity({this.message, this.numOfCartItems, this.cart});
}
