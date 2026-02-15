import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_event.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final GetUserOrdersUseCase _getUserOrdersUseCase;

  OrdersCubit(this._getUserOrdersUseCase)
    : super(const OrdersState(ordersState: BaseState<OrdersResponseEntity>()));

  void onEvent(OrdersEvent event) {
    if (event is GetOrdersEvent) {
      _getUserOrders(filter: event.filter);
    }
  }

  Future<void> _getUserOrders({OrderFilter? filter}) async {
    final filterToApply = filter ?? state.currentFilter;

    emit(
      state.copyWith(
        ordersState: state.ordersState.copyWith(isLoading: true),
        currentFilter: filterToApply,
      ),
    );

    final response = await _getUserOrdersUseCase.getUserOrders(
      filter: filterToApply,
    );

    response.when(
      success: (data) => emit(
        state.copyWith(
          ordersState: state.ordersState.copyWith(
            isLoading: false,
            data: data,
            errorMessage: null,
          ),
          currentFilter: filterToApply,
        ),
      ),
      failure: (errorHandler) => emit(
        state.copyWith(
          ordersState: state.ordersState.copyWith(
            isLoading: false,
            errorMessage: errorHandler.message,
          ),
          currentFilter: filterToApply,
        ),
      ),
    );
  }
}
