import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/data/datasources/remote_orders_data_source.dart';
import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:flower_app/features/orders/domain/repos/orders_repo_contract.dart';

class OrdersRepoImpl implements OrdersRepoContract {
  RemoteOrdersDataSource _remoteOrdersDataSource;

  OrdersRepoImpl(this._remoteOrdersDataSource);

  @override
  Future<BaseResponse<OrdersResponseEntity>> getUserOrders() async {
    final response = await _remoteOrdersDataSource.getUserOrders();
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }
}
