import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/repos/orders_repo_contract.dart';
import 'package:injectable/injectable.dart';

enum OrderFilter { all, active, completed }

@injectable
class GetUserOrdersUseCase {
  final OrdersRepoContract _ordersRepoContract;

  GetUserOrdersUseCase(this._ordersRepoContract);

  Future<BaseResponse<OrdersResponseEntity>> getUserOrders({
    OrderFilter filter = OrderFilter.all,
  }) async {
    final response = await _ordersRepoContract.getUserOrders();

    return response.when(
      success: (data) {
        if (data.orders == null || filter == OrderFilter.all) {
          return BaseResponse.success(data);
        }

        final filteredOrders = _filterOrders(data.orders!, filter);

        return BaseResponse.success(
          OrdersResponseEntity(orders: filteredOrders),
        );
      },
      failure: (errorHandler) => BaseResponse.failure(errorHandler),
    );
  }

  List<OrderEntity> _filterOrders(
    List<OrderEntity> orders,
    OrderFilter filter,
  ) {
    switch (filter) {
      case OrderFilter.active:
        return orders.where((order) {
          return order.state == AppTextConstants.pending ||
              order.state == AppTextConstants.inProgress;
        }).toList();

      case OrderFilter.completed:
        return orders.where((order) {
          return order.state == AppTextConstants.completed ||
              order.state == AppTextConstants.canceled;
        }).toList();

      case OrderFilter.all:
        return orders;
    }
  }
}
