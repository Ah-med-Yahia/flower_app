import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_response/message_response.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';

abstract interface class CartRepository {
  Future<BaseResponse<GetCartResponseEntity>> getCart();
  Future<BaseResponse<GetCartResponseEntity>> addToCart({
    required AddToCartRequestEntity requestEntity,
  });
  Future<BaseResponse<MessageResponse>> clearCart();
  Future<BaseResponse<GetCartResponseEntity>> removeItemFromCart({
    required String productId,
  });
  Future<BaseResponse<GetCartResponseEntity>> updateItemQuantity({
    required String productId,
    required UpdateItemQuantityRequestEntity requestEntity,
  });
}
