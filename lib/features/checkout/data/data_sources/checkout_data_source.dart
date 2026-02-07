import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/order_request_model.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adresses_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/cash_order/cache_response_model/cache_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card_order/credit_card_order_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/user_cart_response_model.dart';

abstract interface class CheckoutDataSource {
  Future<AdressesResponseModel> getAdresses();

  Future<CacheResponseModel> addCacheOrder(OrderRequestModel orderRequestModel);

  Future<CreditCardOrderResponseModel> addCreditCardOrder(
    OrderRequestModel orderRequestModel,
  );

  Future<UserCartResponseModel> getCartInfo();
}
