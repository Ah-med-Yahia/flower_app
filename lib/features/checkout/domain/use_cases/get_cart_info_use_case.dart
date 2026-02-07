import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartInfoUseCase {
  final CheckoutRepository repository;

  const GetCartInfoUseCase(this.repository);

  Future<BaseResponse<CartEntity>> call() {
    return repository.getCartInfo();
  }
}
