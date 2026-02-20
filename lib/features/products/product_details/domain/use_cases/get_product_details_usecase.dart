import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../models/product_response_model.dart';
import '../repo/product_details_repo_contract.dart';

@injectable
class GetProductDetailsUsecase {
  ProductDetailsRepoContract repo;
  GetProductDetailsUsecase(this.repo);

  Future<BaseResponse<ProductResponseModel>> call(String productId) async {
    final response = await repo.getProductDetails(productId);
    return response.when(
      success: (entity) {
        final product = entity.product;
        final productsWithDiscountPercentage =
            product.priceAfterDiscount == null
            ? product.copyWith(inStock: _isInStock(product.quantity))
            : product.copyWith(
                discountPercentage: _calculateDiscountPercentage(
                  product.price,
                  product.priceAfterDiscount!,
                ),
                inStock: _isInStock(product.quantity),
              );
        return BaseResponse.success(
          entity.copyWith(product: productsWithDiscountPercentage),
        );
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }

  String _calculateDiscountPercentage(num price, num afterDiscount) {
    return '${(((price - afterDiscount) / price) * 100).round()}%';
  }

  bool _isInStock(int quantity) {
    return quantity > 0;
  }
}
