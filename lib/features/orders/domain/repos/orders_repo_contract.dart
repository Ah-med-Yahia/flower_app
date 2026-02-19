import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';

abstract interface class OrdersRepoContract {
  Future<BaseResponse<OrdersResponseEntity>> getUserOrders();
}
