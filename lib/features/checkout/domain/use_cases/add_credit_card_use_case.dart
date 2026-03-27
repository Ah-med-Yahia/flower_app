import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/credit_card_order_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddCreditCardUseCase {
  final CheckoutRepository repository;
  const AddCreditCardUseCase(this.repository);
  Future<BaseResponse<CreditCardOrderResponseEntity>> call(
    OrderRequestEntity orderRequest,
  ) {
    return repository.addCreditCardOrder(orderRequest);
  }
}
