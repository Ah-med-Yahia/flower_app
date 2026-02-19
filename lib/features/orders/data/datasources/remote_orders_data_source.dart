import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/data/models/orders_response.dart';

abstract interface class RemoteOrdersDataSource {
  Future<BaseResponse<OrdersResponse>> getUserOrders();
}
