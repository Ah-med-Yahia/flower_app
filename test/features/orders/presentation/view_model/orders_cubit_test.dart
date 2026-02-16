import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/error_handler/error_model.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_event.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'orders_cubit_test.mocks.dart';

@GenerateMocks([GetUserOrdersUseCase])
void main() {
  late OrdersCubit ordersCubit;
  late MockGetUserOrdersUseCase mockGetUserOrdersUseCase;

  setUp(() {
    mockGetUserOrdersUseCase = MockGetUserOrdersUseCase();
    ordersCubit = OrdersCubit(mockGetUserOrdersUseCase);
  });

  tearDown(() => ordersCubit.close());

  group('OrdersCubit - Initial State', () {
    test('should have correct initial state', () {
      expect(ordersCubit.state.ordersState.data, isNull);
      expect(ordersCubit.state.ordersState.isLoading, false);
      expect(ordersCubit.state.currentFilter, OrderFilter.active);
    });
  });

  group('OrdersCubit - GetOrdersEvent', () {
    final tOrders = OrdersResponseEntity(
      orders: [
        OrderEntity(orderNumber: '2', state: 'inProgress'),
        OrderEntity(orderNumber: '1', state: 'pending'),
        OrderEntity(orderNumber: '3', state: 'pending'),
        OrderEntity(orderNumber: '4', state: 'completed'),
        OrderEntity(orderNumber: '5', state: 'canceled'),
        OrderEntity(orderNumber: '6', state: 'completed'),
        OrderEntity(orderNumber: '7', state: 'inProgress'),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Success] when successful with default filter',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.active),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having((s) => s.currentFilter, 'filter', OrderFilter.active),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having((s) => s.currentFilter, 'filter', OrderFilter.active),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Success] when successful with all filter',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.all),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent(filter: OrderFilter.all)),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having((s) => s.currentFilter, 'filter', OrderFilter.all),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having((s) => s.currentFilter, 'filter', OrderFilter.all),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Success] when successful with completed filter',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.completed),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      act: (cubit) =>
          cubit.onEvent(GetOrdersEvent(filter: OrderFilter.completed)),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having((s) => s.currentFilter, 'filter', OrderFilter.completed),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having((s) => s.currentFilter, 'filter', OrderFilter.completed),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [Loading, Failure] when usecase fails',
      build: () {
        final error = ErrorHandler.handle(
          ErrorModel(
            message: ErrorsConstant.internalServerError,
            code: ResponseCode.internalServerError,
          ),
        );
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.active),
        ).thenAnswer((_) async => BaseResponse.failure(error));
        return ordersCubit;
      },
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      expect: () => [
        isA<OrdersState>().having(
          (s) => s.ordersState.isLoading,
          'loading',
          true,
        ),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having(
              (s) => s.ordersState.errorMessage,
              'error',
              ErrorsConstant.internalServerError,
            ),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'uses current filter when no filter is provided',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.completed),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      seed: () => const OrdersState(
        ordersState: BaseState(),
        currentFilter: OrderFilter.completed,
      ),
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having((s) => s.currentFilter, 'filter', OrderFilter.completed),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having((s) => s.currentFilter, 'filter', OrderFilter.completed),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'updates filter when new filter is provided',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.all),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      seed: () => const OrdersState(
        ordersState: BaseState(),
        currentFilter: OrderFilter.active,
      ),
      act: (cubit) => cubit.onEvent(GetOrdersEvent(filter: OrderFilter.all)),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having((s) => s.currentFilter, 'filter', OrderFilter.all),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having((s) => s.currentFilter, 'filter', OrderFilter.all),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'clears error message on successful request',
      build: () {
        when(
          mockGetUserOrdersUseCase.getUserOrders(filter: OrderFilter.active),
        ).thenAnswer((_) async => BaseResponse.success(tOrders));
        return ordersCubit;
      },
      seed: () => const OrdersState(
        ordersState: BaseState(errorMessage: 'Previous error'),
        currentFilter: OrderFilter.active,
      ),
      act: (cubit) => cubit.onEvent(GetOrdersEvent()),
      expect: () => [
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', true)
            .having(
              (s) => s.ordersState.errorMessage,
              'error',
              'Previous error',
            ),
        isA<OrdersState>()
            .having((s) => s.ordersState.isLoading, 'loading', false)
            .having((s) => s.ordersState.data, 'data', tOrders)
            .having(
              (s) => s.ordersState.errorMessage,
              'error',
              'Previous error',
            ),
      ],
    );
  });
}
