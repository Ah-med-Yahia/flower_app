import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import '../entities/get_cart_response_entity.dart';
import '../repositories/cart_repository.dart';

@injectable
class GetCartUseCase {
  final CartRepository _cartRepository;

  GetCartUseCase(this._cartRepository);

  Future<BaseResponse<GetCartResponseEntity>> call() =>
      _cartRepository.getCart();
}
