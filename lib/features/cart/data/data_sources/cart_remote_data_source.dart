import 'package:flower_app/config/base_response/message_response.dart';
import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/update_item_quantity_request_model.dart';

abstract interface class CartRemoteDataSource {
  Future<GetCartResponseModel> getCart();
  Future<GetCartResponseModel> addToCart({
    required AddToCartRequestModel requestModel,
  });
  Future<MessageResponse> clearCart();
  Future<GetCartResponseModel> removeItemFromCart({required String productId});
  Future<GetCartResponseModel> updateItemQuantity({
    required String productId,
    required UpdateItemQuantityRequestModel requestModel,
  });
}
