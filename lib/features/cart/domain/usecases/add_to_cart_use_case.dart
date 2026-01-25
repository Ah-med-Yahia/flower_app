import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import '../entities/add_to_cart_request_entity.dart';
import '../entities/get_cart_response_entity.dart';
import '../repositories/cart_repository.dart';

@injectable
class AddToCartUseCase {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  Future<BaseResponse<GetCartResponseEntity>> call({
    required AddToCartRequestEntity requestEntity,
  }) =>
      _cartRepository.addToCart(requestEntity: requestEntity);
}
