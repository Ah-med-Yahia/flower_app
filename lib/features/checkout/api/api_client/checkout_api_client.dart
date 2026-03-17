import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/order_request_model.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adresses_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/cash_order/cache_response_model/cache_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card_order/credit_card_order_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/user_cart_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'checkout_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @GET(ApiConstants.addressEndPoint)
  Future<AdressesResponseModel> getAdresses();

  @POST(ApiConstants.cacheOrderEndPoint)
  Future<CacheResponseModel> addCacheOrder(
    @Body() OrderRequestModel orderRequestModel,
  );

  @POST(ApiConstants.creditCardOrderEndPoint)
  Future<CreditCardOrderResponseModel> addCreditCardOrder(
    @Body() OrderRequestModel orderRequestModel,
  );

  @GET(ApiConstants.cartEndpoint)
  Future<UserCartResponseModel> getCartInfo();
}
