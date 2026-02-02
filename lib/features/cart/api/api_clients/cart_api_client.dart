import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/message_response.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/update_item_quantity_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'cart_api_client.g.dart';

@singleton
@RestApi()
abstract class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(ApiConstants.cartEndpoint)
  Future<GetCartResponseModel> getCart();

  @POST(ApiConstants.cartEndpoint)
  Future<GetCartResponseModel> addToCart({
    @Body() required AddToCartRequestModel body,
  });

  @DELETE(ApiConstants.cartEndpoint)
  Future<MessageResponse> clearCart();

  @DELETE(ApiConstants.removeItemFromCartEndpoint)
  Future<GetCartResponseModel> removeItemFromCart({
    @Path(ApiConstants.idPathQuery) required String productId,
  });

  @PUT(ApiConstants.updateCartItemEndpoint)
  Future<GetCartResponseModel> updateItemQuantity({
    @Path(ApiConstants.idPathQuery) required String productId,
    @Body() required UpdateItemQuantityRequestModel body,
  });
}
