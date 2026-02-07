import 'package:dio/dio.dart';
import 'package:flower_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flower_app/features/checkout/api/data_sources/checkout_data_source_impl.dart';
import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/order_request_model.dart';
import 'package:flower_app/features/checkout/data/models/response/adresses/adresses_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/cash_order/cache_response_model/cache_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card_order/credit_card_order_response_model.dart';
import 'package:flower_app/features/checkout/data/models/response/get_user_cart/user_cart_response_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'checkout_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckoutApiClient])
void main() {
  late CheckoutDataSourceImpl dataSource;
  late MockCheckoutApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockCheckoutApiClient();
    dataSource = CheckoutDataSourceImpl(mockApiClient);
  });

  group('CheckoutDataSourceImpl', () {
    const tOrderRequestModel = OrderRequestModel();
    final tAddressesResponse = AdressesResponseModel(addresses: []);
    const tCacheResponse = CacheResponseModel(message: 'Success');
    const tCreditCardResponse = CreditCardOrderResponseModel(
      message: 'Success',
    );
    const tCartResponse = UserCartResponseModel(message: 'Success', cart: null);

    group('getAdresses', () {
      test(
        'should return AdressesResponseModel when the call to api client is successful',
        () async {
          // Arrange
          when(
            mockApiClient.getAdresses(),
          ).thenAnswer((_) async => tAddressesResponse);

          // Act
          final result = await dataSource.getAdresses();

          // Assert
          expect(result, equals(tAddressesResponse));
          verify(mockApiClient.getAdresses()).called(1);
        },
      );

      test(
        'should throw an exception when the call to api client is unsuccessful',
        () async {
          // Arrange
          when(mockApiClient.getAdresses()).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act
          final call = dataSource.getAdresses;

          // Assert
          expect(() => call(), throwsA(isA<DioException>()));
        },
      );
    });

    group('addCacheOrder', () {
      test(
        'should return CacheResponseModel when the call to api client is successful',
        () async {
          // Arrange
          when(
            mockApiClient.addCacheOrder(any),
          ).thenAnswer((_) async => tCacheResponse);

          // Act
          final result = await dataSource.addCacheOrder(tOrderRequestModel);

          // Assert
          expect(result, equals(tCacheResponse));
          verify(mockApiClient.addCacheOrder(tOrderRequestModel)).called(1);
        },
      );

      test(
        'should throw an exception when the call to api client is unsuccessful',
        () async {
          // Arrange
          when(mockApiClient.addCacheOrder(any)).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act
          final call = dataSource.addCacheOrder;

          // Assert
          expect(() => call(tOrderRequestModel), throwsA(isA<DioException>()));
        },
      );
    });

    group('addCreditCardOrder', () {
      test(
        'should return CreditCardOrderResponseModel when the call to api client is successful',
        () async {
          // Arrange
          when(
            mockApiClient.addCreditCardOrder(any),
          ).thenAnswer((_) async => tCreditCardResponse);

          // Act
          final result = await dataSource.addCreditCardOrder(
            tOrderRequestModel,
          );

          // Assert
          expect(result, equals(tCreditCardResponse));
          verify(
            mockApiClient.addCreditCardOrder(tOrderRequestModel),
          ).called(1);
        },
      );

      test(
        'should throw an exception when the call to api client is unsuccessful',
        () async {
          // Arrange
          when(mockApiClient.addCreditCardOrder(any)).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act
          final call = dataSource.addCreditCardOrder;

          // Assert
          expect(() => call(tOrderRequestModel), throwsA(isA<DioException>()));
        },
      );
    });

    group('getCartInfo', () {
      test(
        'should return UserCartResponseModel when the call to api client is successful',
        () async {
          // Arrange
          when(
            mockApiClient.getCartInfo(),
          ).thenAnswer((_) async => tCartResponse);

          // Act
          final result = await dataSource.getCartInfo();

          // Assert
          expect(result, equals(tCartResponse));
          verify(mockApiClient.getCartInfo()).called(1);
        },
      );

      test(
        'should throw an exception when the call to api client is unsuccessful',
        () async {
          // Arrange
          when(mockApiClient.getCartInfo()).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
            ),
          );

          // Act
          final call = dataSource.getCartInfo;

          // Assert
          expect(() => call(), throwsA(isA<DioException>()));
        },
      );
    });
  });
}
