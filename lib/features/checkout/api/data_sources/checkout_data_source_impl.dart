import 'package:flower_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/order_request_model.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adresses_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/cash_order/cache_response_model/cache_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card_order/credit_card_order_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/user_cart_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutDataSource)
class CheckoutDataSourceImpl implements CheckoutDataSource {
  final CheckoutApiClient _checkoutApiClient;

  CheckoutDataSourceImpl(this._checkoutApiClient);

  @override
  Future<CacheResponseModel> addCacheOrder(
    OrderRequestModel orderRequestModel,
  ) async => await _checkoutApiClient.addCacheOrder(orderRequestModel);

  @override
  Future<CreditCardOrderResponseModel> addCreditCardOrder(
    OrderRequestModel orderRequestModel,
  ) async => await _checkoutApiClient.addCreditCardOrder(orderRequestModel);

  @override
  Future<AdressesResponseModel> getAdresses() async =>
      await _checkoutApiClient.getAdresses();

  @override
  Future<UserCartResponseModel> getCartInfo() async =>
      await _checkoutApiClient.getCartInfo();
}
