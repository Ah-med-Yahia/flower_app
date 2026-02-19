import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/orders/api/api_client/orders_api_client.dart';
import 'package:flower_app/features/orders/data/datasources/remote_orders_data_source.dart';
import 'package:flower_app/features/orders/data/models/orders_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteOrdersDataSource)
class RemoteOrdersDataSourceImpl implements RemoteOrdersDataSource {
  final OrdersApiClient _ordersApiClient;

  RemoteOrdersDataSourceImpl(this._ordersApiClient);

  @override
  Future<BaseResponse<OrdersResponse>> getUserOrders() {
    return safeApiCall<OrdersResponse>(() => _ordersApiClient.getUserOrders());
  }
}
