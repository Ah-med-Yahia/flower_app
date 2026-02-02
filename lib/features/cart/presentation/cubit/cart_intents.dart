import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';

abstract class CartIntents {}

class GetCartIntent extends CartIntents {}

class UpdateItemQuantityIntent extends CartIntents {
  final String productId;
  final UpdateItemQuantityRequestEntity requestEntity;

  UpdateItemQuantityIntent({
    required this.productId,
    required this.requestEntity,
  });
}

class RemoveItemFromCartIntent extends CartIntents {
  final String productId;

  RemoveItemFromCartIntent({required this.productId});
}

class ClearCartIntent extends CartIntents {}
