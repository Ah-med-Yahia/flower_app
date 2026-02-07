import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/credit_card_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';

abstract interface class CheckoutRepository {
  Future<BaseResponse<CartEntity>> getCartInfo();

  Future<BaseResponse<CacheOrderResponseEntity>> addCacheOrder(
    OrderRequestEntity request,
  );

  Future<BaseResponse<CreditCardOrderResponseEntity>> addCreditCardOrder(
    OrderRequestEntity request,
  );

  Future<BaseResponse<List<AddressEntity>>> getAddresses();
}
