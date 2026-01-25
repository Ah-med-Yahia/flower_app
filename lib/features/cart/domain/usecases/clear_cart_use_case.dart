import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import '../entities/clear_cart_response_entity.dart';
import '../repositories/cart_repository.dart';

@injectable
class ClearCartUseCase {
  final CartRepository _cartRepository;

  ClearCartUseCase(this._cartRepository);

  Future<BaseResponse<ClearCartResponseEntity>> call() =>
      _cartRepository.clearCart();
}
