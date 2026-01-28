import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_response/message_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/data/mappers/add_to_cart_request_mapper.dart';
import 'package:flower_app/features/cart/data/mappers/get_cart_response_mapper.dart';
import 'package:flower_app/features/cart/data/mappers/update_item_quantity_request_mapper.dart';
import 'package:flower_app/features/cart/domain/entities/add_to_cart_request_entity.dart';
import 'package:flower_app/features/cart/domain/entities/get_cart_response_entity.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<GetCartResponseEntity>> getCart() async {
    return safeApiCall<GetCartResponseEntity>(() async {
      final response = await _remoteDataSource.getCart();
      return response.toEntity();
    });
  }

  @override
  Future<BaseResponse<GetCartResponseEntity>> addToCart({
    required AddToCartRequestEntity requestEntity,
  }) async {
    return safeApiCall<GetCartResponseEntity>(() async {
      final response = await _remoteDataSource.addToCart(
        requestModel: requestEntity.toModel(),
      );
      return response.toEntity();
    });
  }

  @override
  Future<BaseResponse<MessageResponse>> clearCart() async {
    return safeApiCall<MessageResponse>(() async {
      return await _remoteDataSource.clearCart();
    });
  }

  @override
  Future<BaseResponse<GetCartResponseEntity>> removeItemFromCart({
    required String productId,
  }) async {
    return safeApiCall<GetCartResponseEntity>(() async {
      final response = await _remoteDataSource.removeItemFromCart(
        productId: productId,
      );
      return response.toEntity();
    });
  }

  @override
  Future<BaseResponse<GetCartResponseEntity>> updateItemQuantity({
    required String productId,
    required UpdateItemQuantityRequestEntity requestEntity,
  }) async {
    return safeApiCall<GetCartResponseEntity>(() async {
      final response = await _remoteDataSource.updateItemQuantity(
        productId: productId,
        requestModel: requestEntity.toModel(),
      );
      return response.toEntity();
    });
  }
}
