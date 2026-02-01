import 'package:flower_app/features/checkout/domain/entities/cart/user_cart_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_model.dart';
part 'user_cart_response_model.g.dart';

@JsonSerializable()
class UserCartResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'numOfCartItems')
  final int? numOfCartItems;
  @JsonKey(name: 'cart')
  final CartModel? cart;

  const UserCartResponseModel({this.message, this.numOfCartItems, this.cart});

  factory UserCartResponseModel.fromJson(Map<String, dynamic> json) =>
      UserCartResponseModel(
        message: json['message'] as String?,
        numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
        cart: json['cart'] == null
            ? null
            : CartModel.fromJson(json['cart'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
    'message': message,
    'numOfCartItems': numOfCartItems,
    'cart': cart?.toJson(),
  };

  UserCartResponseEntity toEntity() {
    return UserCartResponseEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toEntity(),
    );
  }
}
