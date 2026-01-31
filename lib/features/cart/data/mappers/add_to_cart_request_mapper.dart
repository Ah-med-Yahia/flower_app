import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';

extension AddToCartRequestMapper on AddToCartRequestEntity {
  AddToCartRequestModel toModel() {
    return AddToCartRequestModel(productId: productId, quantity: quantity);
  }
}
