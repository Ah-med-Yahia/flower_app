import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';

class OrdersState {
  final BaseState<OrdersResponseEntity> ordersState;
  final OrderFilter currentFilter;

  const OrdersState({
    required this.ordersState,
    this.currentFilter = OrderFilter.active,
  });

  OrdersState copyWith({
    BaseState<OrdersResponseEntity>? ordersState,
    OrderFilter? currentFilter,
  }) {
    return OrdersState(
      ordersState: ordersState ?? this.ordersState,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}
