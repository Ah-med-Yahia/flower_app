import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import '../entities/get_cart_response_entity.dart';
import '../entities/update_item_quantity_request_entity.dart';
import '../repositories/cart_repository.dart';

@injectable
class UpdateItemQuantityUseCase {
  final CartRepository _cartRepository;

  UpdateItemQuantityUseCase(this._cartRepository);

  Future<BaseResponse<GetCartResponseEntity>> call({
    required String productId,
    required UpdateItemQuantityRequestEntity requestEntity,
  }) =>
      _cartRepository.updateItemQuantity(
        productId: productId,
        requestEntity: requestEntity,
      );
}
