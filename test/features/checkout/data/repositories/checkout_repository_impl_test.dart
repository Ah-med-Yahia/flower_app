import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_data_source.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adress_model.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adresses_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/cash_order/cache_response_model/cache_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card_order/credit_card_order_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/cart_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/user_cart_response_model.dart';
import 'package:flower_app/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/credit_card_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'checkout_repository_impl_test.mocks.dart';

@GenerateMocks([CheckoutDataSource])
void main() {
  late CheckoutRepositoryImpl repository;
  late MockCheckoutDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCheckoutDataSource();
    repository = CheckoutRepositoryImpl(mockDataSource);
  });

  group('CheckoutRepositoryImpl', () {
    final tOrderRequestEntity = OrderRequestEntity();

    const tAddressModel = AdressModel(id: '1', street: 'Street');
    final tAddressesResponse = AdressesResponseModel(
      addresses: [tAddressModel],
    );

    const tCacheResponse = CacheResponseModel(message: 'Success');

    const tCreditResponse = CreditCardOrderResponseModel(message: 'Success');

    const tCartResponse = UserCartResponseModel(
      cart: CartModel(totalPrice: 100),
    );

    group('getAddresses', () {
      test(
        'should return list of AddressEntity when call to data source is successful',
        () async {
          // Arrange
          when(
            mockDataSource.getAdresses(),
          ).thenAnswer((_) async => tAddressesResponse);

          // Act
          final result = await repository.getAddresses();

          // Assert
          expect(result, isA<Success<List<AddressEntity>>>());

          verify(mockDataSource.getAdresses()).called(1);
        },
      );

      test(
        'should return Failure when call to data source is unsuccessful',
        () async {
          // Arrange
          when(mockDataSource.getAdresses()).thenThrow(Exception());

          // Act
          final result = await repository.getAddresses();

          // Assert
          expect(result, isA<Failure<List<AddressEntity>>>());
          verify(mockDataSource.getAdresses()).called(1);
        },
      );
    });

    group('addCacheOrder', () {
      test(
        'should return CacheOrderResponseEntity when call to data source is successful',
        () async {
          // Arrange
          when(
            mockDataSource.addCacheOrder(any),
          ).thenAnswer((_) async => tCacheResponse);

          // Act
          final result = await repository.addCacheOrder(tOrderRequestEntity);

          // Assert
          expect(result, isA<Success<CacheOrderResponseEntity>>());
          verify(mockDataSource.addCacheOrder(any)).called(1);
        },
      );

      test(
        'should return Failure when call to data source is unsuccessful',
        () async {
          // Arrange
          when(mockDataSource.addCacheOrder(any)).thenThrow(Exception());

          // Act
          final result = await repository.addCacheOrder(tOrderRequestEntity);

          // Assert
          expect(result, isA<Failure<CacheOrderResponseEntity>>());
          verify(mockDataSource.addCacheOrder(any)).called(1);
        },
      );
    });

    group('addCreditCardOrder', () {
      test(
        'should return CreditCardOrderResponseEntity when call to data source is successful',
        () async {
          // Arrange
          when(
            mockDataSource.addCreditCardOrder(any),
          ).thenAnswer((_) async => tCreditResponse);

          // Act
          final result = await repository.addCreditCardOrder(
            tOrderRequestEntity,
          );

          // Assert
          expect(result, isA<Success<CreditCardOrderResponseEntity>>());
          verify(mockDataSource.addCreditCardOrder(any)).called(1);
        },
      );

      test(
        'should return Failure when call to data source is unsuccessful',
        () async {
          // Arrange
          when(mockDataSource.addCreditCardOrder(any)).thenThrow(Exception());

          // Act
          final result = await repository.addCreditCardOrder(
            tOrderRequestEntity,
          );

          // Assert
          expect(result, isA<Failure<CreditCardOrderResponseEntity>>());
          verify(mockDataSource.addCreditCardOrder(any)).called(1);
        },
      );
    });

    group('getCartInfo', () {
      test(
        'should return CartEntity when call to data source is successful',
        () async {
          // Arrange
          when(
            mockDataSource.getCartInfo(),
          ).thenAnswer((_) async => tCartResponse);

          // Act
          final result = await repository.getCartInfo();

          // Assert
          expect(result, isA<Success<CartEntity>>());
          verify(mockDataSource.getCartInfo()).called(1);
        },
      );

      test(
        'should return Failure when call to data source is unsuccessful',
        () async {
          // Arrange
          when(mockDataSource.getCartInfo()).thenThrow(Exception());

          // Act
          final result = await repository.getCartInfo();

          // Assert
          expect(result, isA<Failure<CartEntity>>());
          verify(mockDataSource.getCartInfo()).called(1);
        },
      );
    });
  });
}
