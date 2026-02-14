import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/orders/api/api_client/orders_api_client.dart';
import 'package:flower_app/features/orders/api/datasources_impl/remote_orders_data_source_impl.dart';
import 'package:flower_app/features/orders/data/models/order_item_model.dart';
import 'package:flower_app/features/orders/data/models/order_model.dart';
import 'package:flower_app/features/orders/data/models/order_product_model.dart';
import 'package:flower_app/features/orders/data/models/orders_metadata.dart';
import 'package:flower_app/features/orders/data/models/orders_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'remote_orders_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late MockOrdersApiClient mockOrdersApiClient;
  late RemoteOrdersDataSourceImpl remoteOrdersDataSourceImpl;
  setUpAll(() {
    mockOrdersApiClient = MockOrdersApiClient();
    remoteOrdersDataSourceImpl = RemoteOrdersDataSourceImpl(
      mockOrdersApiClient,
    );
  });

  group('Get user orders data sources implementation test cases', () {
    _testGetUserOrdersSuccessCase(
      mockOrdersApiClient,
      remoteOrdersDataSourceImpl,
    );
    _testGetUserOrdersSuccessCaseWithEmptyOrdersList(
      mockOrdersApiClient,
      remoteOrdersDataSourceImpl,
    );
    _testGetUserOrdersFailureCase(
      mockOrdersApiClient,
      remoteOrdersDataSourceImpl,
    );
    _testGetUserOrddersFilurecaseDioEXception(
      mockOrdersApiClient,
      remoteOrdersDataSourceImpl,
    );
  });
}

void _testGetUserOrdersSuccessCase(
  MockOrdersApiClient mockOrdersApiClient,
  RemoteOrdersDataSourceImpl remoteOrdersDataSourceImpl,
) {
  test(
    'should return list of orders when get user orders successfully',
    () async {
      final OrdersResponse mockResponse = OrdersResponse(
        message: 'Orders fetched successfully',
        metadata: OrdersMetadata(
          currentPage: 1,
          totalPages: 1,
          limit: 10,
          totalItems: 5,
        ),
        orders: [
          OrderModel(
            id: '66a1b2c3d4e5f67890123456',
            user: '60d21b4667d0d8992e610c85',
            orderNumber: 'ORD-2024-0001',
            orderItems: [
              OrderItemModel(
                id: '66b2c3d4e5f6789012345678',
                product: OrderProductModel(
                  id: '60d21b4667d0d8992e610c90',
                  title: 'Red Roses Bouquet',
                  slug: 'red-roses-bouquet',
                  description: '12 fresh red roses with baby breath',
                  imgCover: 'https://example.com/red-roses.jpg',
                  images: [
                    'https://example.com/red-roses-1.jpg',
                    'https://example.com/red-roses-2.jpg',
                  ],
                  price: 35000,
                  priceAfterDiscount: 29900,
                  quantity: 100,
                  rateAvg: 4,
                  rateCount: 45,
                ),
                price: 29900,
                quantity: 2,
              ),
            ],
            totalPrice: 59800,
            paymentType: 'card',
            isPaid: true,
            isDelivered: true,
            state: 'delivered',
            createdAt: '2024-03-01T10:30:00Z',
            updatedAt: '2024-03-03T15:20:00Z',
          ),
          OrderModel(
            id: '66a2b3c4d5e6f78901234567',
            user: '60d21b4667d0d8992e610c86',
            orderNumber: 'ORD-2024-0002',
            orderItems: [
              OrderItemModel(
                id: '66b3c4d5e6f7890123456789',
                product: OrderProductModel(
                  id: '60d21b4667d0d8992e610c91',
                  title: 'White Lilies',
                  slug: 'white-lilies',
                  description: 'Elegant white lily arrangement',
                  imgCover: 'https://example.com/lilies.jpg',
                  images: ['https://example.com/lilies-1.jpg'],
                  price: 45000,
                  priceAfterDiscount: 39900,
                  quantity: 50,
                  rateAvg: 5,
                  rateCount: 32,
                ),
                price: 39900,
                quantity: 1,
              ),
            ],
            totalPrice: 39900,
            paymentType: 'cod',
            isPaid: false,
            isDelivered: false,
            state: 'pending',
            createdAt: '2024-03-05T14:15:00Z',
            updatedAt: '2024-03-05T14:15:00Z',
          ),
          OrderModel(
            id: '66a3b4c5d6e7f89012345678',
            user: '60d21b4667d0d8992e610c87',
            orderNumber: 'ORD-2024-0003',
            orderItems: [
              OrderItemModel(
                id: '66b4c5d6e7f8901234567890',
                product: OrderProductModel(
                  id: '60d21b4667d0d8992e610c92',
                  title: 'Sunflower Bunch',
                  slug: 'sunflower-bunch',
                  description: '5 bright sunflowers',
                  imgCover: 'https://example.com/sunflowers.jpg',
                  images: [
                    'https://example.com/sunflowers-1.jpg',
                    'https://example.com/sunflowers-2.jpg',
                  ],
                  price: 25000,
                  priceAfterDiscount: 22500,
                  quantity: 75,
                  rateAvg: 4,
                  rateCount: 28,
                ),
                price: 22500,
                quantity: 3,
              ),
            ],
            totalPrice: 67500,
            paymentType: 'card',
            isPaid: true,
            isDelivered: false,
            state: 'shipped',
            createdAt: '2024-03-07T09:45:00Z',
            updatedAt: '2024-03-08T11:30:00Z',
          ),
          OrderModel(
            id: '66a4b5c6d7e8f90123456789',
            user: '60d21b4667d0d8992e610c88',
            orderNumber: 'ORD-2024-0004',
            orderItems: [
              OrderItemModel(
                id: '66b5c6d7e8f9012345678901',
                product: OrderProductModel(
                  id: '60d21b4667d0d8992e610c93',
                  title: 'Mixed Spring Flowers',
                  slug: 'mixed-spring-flowers',
                  description: 'Colorful mix of tulips and daffodils',
                  imgCover: 'https://example.com/spring.jpg',
                  images: ['https://example.com/spring-1.jpg'],
                  price: 30000,
                  priceAfterDiscount: null,
                  quantity: 60,
                  rateAvg: 4,
                  rateCount: 19,
                ),
                price: 30000,
                quantity: 1,
              ),
            ],
            totalPrice: 30000,
            paymentType: 'card',
            isPaid: true,
            isDelivered: true,
            state: 'delivered',
            createdAt: '2024-03-02T16:20:00Z',
            updatedAt: '2024-03-04T13:40:00Z',
          ),
          OrderModel(
            id: '66a5b6c7d8e9f01234567890',
            user: '60d21b4667d0d8992e610c89',
            orderNumber: 'ORD-2024-0005',
            orderItems: [
              OrderItemModel(
                id: '66b6c7d8e9f0123456789012',
                product: OrderProductModel(
                  id: '60d21b4667d0d8992e610c94',
                  title: 'Premium Roses Box',
                  slug: 'premium-roses-box',
                  description: '24 red roses in luxury box',
                  imgCover: 'https://example.com/premium-roses.jpg',
                  images: [
                    'https://example.com/premium-1.jpg',
                    'https://example.com/premium-2.jpg',
                  ],
                  price: 65000,
                  priceAfterDiscount: 54900,
                  quantity: 25,
                  rateAvg: 5,
                  rateCount: 67,
                ),
                price: 54900,
                quantity: 1,
              ),
            ],
            totalPrice: 54900,
            paymentType: 'card',
            isPaid: true,
            isDelivered: false,
            state: 'processing',
            createdAt: '2024-03-10T12:00:00Z',
            updatedAt: '2024-03-10T12:00:00Z',
          ),
        ],
      );
      when(
        mockOrdersApiClient.getUserOrders(),
      ).thenAnswer((_) async => mockResponse);

      final result = await remoteOrdersDataSourceImpl.getUserOrders();
      final success = result as Success<OrdersResponse>;

      expect(result, isA<OrdersResponse>);
      expect(success.data, equals(mockResponse));
      expect(success.data.message, 'Success');
      expect(success.data.metadata, equals(mockResponse.metadata));
      expect(success.data.orders, equals(mockResponse.orders));
      expect(success.data.orders!.length, 5);
      verify(mockOrdersApiClient.getUserOrders()).called(1);
    },
  );
}

void _testGetUserOrdersSuccessCaseWithEmptyOrdersList(
  MockOrdersApiClient mockOrdersApiClient,
  RemoteOrdersDataSourceImpl remoteOrdersDataSourceImpl,
) {
  test(
    'should return empty list of orders when get user orders successfully',
    () async {
      final OrdersResponse mockResponse = OrdersResponse(
        message: 'Orders fetched successfully',
        metadata: OrdersMetadata(
          currentPage: 1,
          totalPages: 1,
          limit: 10,
          totalItems: 5,
        ),
        orders: [],
      );
      when(
        mockOrdersApiClient.getUserOrders(),
      ).thenAnswer((_) async => mockResponse);

      final result = await remoteOrdersDataSourceImpl.getUserOrders();
      final success = result as Success<OrdersResponse>;

      expect(result, isA<OrdersResponse>);
      expect(success.data, equals(mockResponse));
      expect(success.data.message, 'Success');
      expect(success.data.metadata, equals(mockResponse.metadata));
      expect(success.data.orders!.length, 0);
    },
  );
}

void _testGetUserOrdersFailureCase(
  MockOrdersApiClient mockOrdersApiClient,
  RemoteOrdersDataSourceImpl remoteOrdersDataSourceImpl,
) {
  test('should return error when get user orders fails', () async {
    final dummyError = ErrorHandler.handle(Exception('Failed to fetch orders'));
    when(mockOrdersApiClient.getUserOrders()).thenThrow(dummyError);

    final result = await remoteOrdersDataSourceImpl.getUserOrders();
    final failure = result as Failure<OrdersResponse>;
    expect(failure, isA<Failure<OrdersResponse>>());
    expect(failure.errorHandler, equals(dummyError));
    expect(
      failure.errorHandler.errorModel.message,
      ErrorsConstant.defaultError,
    );
    verify(mockOrdersApiClient.getUserOrders()).called(1);
  });
}

void _testGetUserOrddersFilurecaseDioEXception(
  MockOrdersApiClient mockOrdersApiClient,
  RemoteOrdersDataSourceImpl remoteOrdersDataSourceImpl,
) {
  test(
    'should return error when get user orders fails with dio exception ',
    () async {
      final dummyError = DioException(
        requestOptions: RequestOptions(path: '/orders'),
        type: DioExceptionType.connectionError,
      );
      final handledError = ErrorHandler.handle(dummyError);
      when(mockOrdersApiClient.getUserOrders()).thenThrow(handledError);
      final result = await remoteOrdersDataSourceImpl.getUserOrders();
      final failure = result as Failure<OrdersResponse>;
      expect(failure, isA<Failure<OrdersResponse>>());
      expect(failure.errorHandler, equals(handledError));
      expect(
        failure.errorHandler.errorModel.message,
        ErrorsConstant.noInternetError,
      );
      expect(
        failure.errorHandler.errorModel.code,
        handledError.errorModel.code,
      );
      expect(
        failure.errorHandler.errorModel.message,
        handledError.errorModel.message,
      );
      verify(mockOrdersApiClient.getUserOrders()).called(1);
    },
  );
}
