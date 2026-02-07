import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddCacheOrderUseCase {
  final CheckoutRepository repository;
  const AddCacheOrderUseCase(this.repository);
  Future<BaseResponse<CacheOrderResponseEntity>> call(
    OrderRequestEntity orderRequest,
  ) {
    return repository.addCacheOrder(orderRequest);
  }
}
