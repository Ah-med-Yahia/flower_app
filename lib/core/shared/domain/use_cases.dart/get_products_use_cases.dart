import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepo _productsRepo;

  GetProductsUseCase(this._productsRepo);

  Future<BaseResponse<ProductsResponseEntity>> call({
    String? keyword,
    String? categoryId,
    String? sortOption,
  }) async {
    final response = await _productsRepo.getProducts(
      keyword: keyword,
      categoryId: categoryId,
      sortOption: sortOption,
    );
    return response.when(
      success: (entity) {
        final products = entity.products;
        if (products.isEmpty) return BaseResponse.success(entity);
        final productsWithDiscountPercentage = products.map((product) {
          return product.priceAfterDiscount == null
              ? product.copyWith(inStock: _isInStock(product.quantity))
              : product.copyWith(
                  discountPercentage: _calculateDiscountPercentage(
                    product.price,
                    product.priceAfterDiscount!,
                  ),
                  inStock: _isInStock(product.quantity),
                );
        }).toList();
        return BaseResponse.success(
          entity.copyWith(products: productsWithDiscountPercentage),
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
