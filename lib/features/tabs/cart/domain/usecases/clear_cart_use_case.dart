import 'package:flower_app/core/shared/data/models/message_response.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import '../repositories/cart_repository.dart';

@injectable
class ClearCartUseCase {
  final CartRepository _cartRepository;

  ClearCartUseCase(this._cartRepository);

  Future<BaseResponse<MessageResponse>> call() => _cartRepository.clearCart();
}
