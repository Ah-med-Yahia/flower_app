import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/orders/data/repos/orders_repo_impl.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_user_orders_usecase_test.mocks.dart';

@GenerateMocks([OrdersRepoImpl])
void main() {
  late MockOrdersRepoImpl mockOrdersRepoImpl;
  late GetUserOrdersUseCase getUserOrdersUseCase;
  setUp(() {
    mockOrdersRepoImpl = MockOrdersRepoImpl();
    getUserOrdersUseCase = GetUserOrdersUseCase(mockOrdersRepoImpl);
  });
  group('get user orders usecase  test cases', () {
    _testGetUserOrdersUseCaseWhenFilterIsActive(
      mockOrdersRepoImpl,
      getUserOrdersUseCase,
    );
    _testGetUserOrdersUseCaseWhenFilterIsCompleted(
      mockOrdersRepoImpl,
      getUserOrdersUseCase,
    );
    _testGetUserOrdersUseCaseWhenFilterIsAll(
      mockOrdersRepoImpl,
      getUserOrdersUseCase,
    );
    testGetUserOrdersUseCaseErrorCases(
      mockOrdersRepoImpl,
      getUserOrdersUseCase,
    );
  });
}

void _testGetUserOrdersUseCaseWhenFilterIsActive(
  MockOrdersRepoImpl mockOrdersRepoImpl,
  GetUserOrdersUseCase getUserOrdersUseCase,
) {
  test('should return list of active orders when success case', () async {
    final fakeOrdersResponse = OrdersResponseEntity(
      orders: [
        OrderEntity(orderNumber: '2', state: 'in progress'),
        OrderEntity(orderNumber: '1', state: 'pending'),
        OrderEntity(orderNumber: '3', state: 'pending'),
        OrderEntity(orderNumber: '4', state: 'completed'),
        OrderEntity(orderNumber: '5', state: 'canceled'),
        OrderEntity(orderNumber: '6', state: 'completed'),
        OrderEntity(orderNumber: '7', state: 'in progress'),
      ],
    );
    when(mockOrdersRepoImpl.getUserOrders()).thenAnswer(
      (_) async => BaseResponse.success(
        OrdersResponseEntity(orders: fakeOrdersResponse.orders),
      ),
    );

    final result = await getUserOrdersUseCase.getUserOrders(
      filter: OrderFilter.active,
    );

    final success = result as Success<OrdersResponseEntity>;
    expect(success.data.orders!.length, 4);
    expect(
      success.data.orders!.every((order) {
        return order.state == 'pending' || order.state == 'in progress';
      }),
      isTrue,
    );
    verify(mockOrdersRepoImpl.getUserOrders()).called(1);
  });
}

void _testGetUserOrdersUseCaseWhenFilterIsCompleted(
  MockOrdersRepoImpl mockOrdersRepoImpl,
  GetUserOrdersUseCase getUserOrdersUseCase,
) {
  test('should return list of completed orders when success case', () async {
    final manyOrders = [
      OrderEntity(orderNumber: '2', state: 'in progress'),
      OrderEntity(orderNumber: '1', state: 'pending'),
      OrderEntity(orderNumber: '3', state: 'pending'),
      OrderEntity(orderNumber: '4', state: 'completed'),
      OrderEntity(orderNumber: '5', state: 'canceled'),
      OrderEntity(orderNumber: '6', state: 'completed'),
      OrderEntity(orderNumber: '7', state: 'in progress'),
      OrderEntity(orderNumber: '8', state: 'canceled'),
      OrderEntity(orderNumber: '9', state: 'completed'),
    ];
    when(mockOrdersRepoImpl.getUserOrders()).thenAnswer(
      (_) async =>
          BaseResponse.success(OrdersResponseEntity(orders: manyOrders)),
    );
    final result = await getUserOrdersUseCase.getUserOrders(
      filter: OrderFilter.completed,
    );
    final success = result as Success<OrdersResponseEntity>;
    expect(success.data.orders!.length, 5);
    expect(
      success.data.orders!.every((order) {
        return order.state == 'completed' || order.state == 'canceled';
      }),
      isTrue,
    );
    verify(mockOrdersRepoImpl.getUserOrders()).called(1);
  });
}

void _testGetUserOrdersUseCaseWhenFilterIsAll(
  MockOrdersRepoImpl mockOrdersRepoImpl,
  GetUserOrdersUseCase getUserOrdersUseCase,
) {
  test('should return list of all orders when success case', () async {
    final manyOrders = [
      OrderEntity(orderNumber: '2', state: 'in progress'),
      OrderEntity(orderNumber: '1', state: 'pending'),
      OrderEntity(orderNumber: '3', state: 'pending'),
      OrderEntity(orderNumber: '4', state: 'completed'),
      OrderEntity(orderNumber: '5', state: 'canceled'),
      OrderEntity(orderNumber: '6', state: 'completed'),
      OrderEntity(orderNumber: '7', state: 'in progress'),
    ];
    when(mockOrdersRepoImpl.getUserOrders()).thenAnswer(
      (_) async =>
          BaseResponse.success(OrdersResponseEntity(orders: manyOrders)),
    );
    final result = await getUserOrdersUseCase.getUserOrders(
      filter: OrderFilter.all,
    );
    final success = result as Success<OrdersResponseEntity>;
    expect(success.data.orders!.length, 7);
  });
}

void testGetUserOrdersUseCaseErrorCases(
  MockOrdersRepoImpl mockOrdersRepoImpl,
  GetUserOrdersUseCase getUserOrdersUseCase,
) {
  test(
    'should return failure when repository returns a failure response',
    () async {
      final dummyError = ErrorHandler.handle(
        Exception('Failed to fetch orders'),
      );

      when(
        mockOrdersRepoImpl.getUserOrders(),
      ).thenAnswer((_) async => BaseResponse.failure(dummyError));

      final result = await getUserOrdersUseCase.getUserOrders();

      expect(result, isA<Failure<OrdersResponseEntity>>());

      final failure = result as Failure<OrdersResponseEntity>;
      expect(
        failure.errorHandler.errorModel.message,
        ErrorsConstant.defaultError,
      );
      verify(mockOrdersRepoImpl.getUserOrders()).called(1);
    },
  );
}
