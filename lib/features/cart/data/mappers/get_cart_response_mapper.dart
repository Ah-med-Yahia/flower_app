import 'package:flower_app/features/cart/data/mappers/cart_mapper.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';

extension GetCartResponseMapper on GetCartResponseModel {
  GetCartResponseEntity toEntity() {
    return GetCartResponseEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart.toEntity(),
    );
  }
}
