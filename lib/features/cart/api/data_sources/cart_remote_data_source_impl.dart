import 'package:flower_app/features/cart/api/api_clients/cart_api_client.dart';
import 'package:flower_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/data/models/add_to_cart_request_model.dart';
import 'package:flower_app/features/cart/data/models/clear_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response_model/get_cart_response_model.dart';
import 'package:flower_app/features/cart/data/models/update_item_quantity_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartApiClient _apiClient;
  CartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<GetCartResponseModel> getCart() {
    return _apiClient.getCart();
  }

  @override
  Future<GetCartResponseModel> addToCart({required AddToCartRequestModel requestModel}) {
    return _apiClient.addToCart(body: requestModel);
  }

  @override
  Future<ClearCartResponseModel> clearCart() {
    return _apiClient.clearCart();
  }

  @override
  Future<GetCartResponseModel> removeItemFromCart({required String productId}) {
    return _apiClient.removeItemFromCart(productId: productId);
  }

  @override
  Future<GetCartResponseModel> updateItemQuantity({required String productId, required UpdateItemQuantityRequestModel requestModel}) {
    return _apiClient.updateItemQuantity(productId: productId, body: requestModel);
  }
}