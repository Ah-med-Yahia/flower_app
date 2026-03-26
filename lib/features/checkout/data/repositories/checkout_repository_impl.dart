import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_data_source.dart';
import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/order_request_model.dart';
import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/shipping_address_model.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/credit_card_order_response_entity.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adress_model.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutDataSource _dataSource;
  final List<AdressModel> _cachedAddresses = [];

  CheckoutRepositoryImpl(this._dataSource);

  @override
  Future<BaseResponse<CacheOrderResponseEntity>> addCacheOrder(
    OrderRequestEntity request,
  ) async {
    return await safeApiCall<CacheOrderResponseEntity>(() async {
      final shippingAddress = _cachedAddresses
          .where((e) => e.id == request.addressId)
          .firstOrNull;

      final orderRequestModel = OrderRequestModel(
        shippingAddress: shippingAddress == null
            ? null
            : ShippingAddressModel.fromAdressModel(shippingAddress),
      );

      final response = await _dataSource.addCacheOrder(orderRequestModel);
      return response.toEntity();
    });
  }

  @override
  Future<BaseResponse<CreditCardOrderResponseEntity>> addCreditCardOrder(
    OrderRequestEntity request,
  ) async {
    return await safeApiCall<CreditCardOrderResponseEntity>(() async {
      final shippingAddress = _cachedAddresses
          .where((e) => e.id == request.addressId)
          .firstOrNull;

      final orderRequestModel = OrderRequestModel(
        shippingAddress: shippingAddress == null
            ? null
            : ShippingAddressModel.fromAdressModel(shippingAddress),
      );

      final response = await _dataSource.addCreditCardOrder(orderRequestModel);
      return response.toEntity();
    });
  }

  @override
  Future<BaseResponse<List<AddressEntity>>> getAddresses() async {
    return await safeApiCall<List<AddressEntity>>(() async {
      final response = await _dataSource.getAdresses();
      _cachedAddresses.clear();
      _cachedAddresses.addAll(response.addresses ?? []);
      return response.addresses!.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<BaseResponse<CartEntity>> getCartInfo() {
    return safeApiCall<CartEntity>(() async {
      final response = await _dataSource.getCartInfo();
      return response.cart?.toEntity() ?? const CartEntity();
    });
  }
}
