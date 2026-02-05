import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryProductsUsecase {
  final CategoriesRepo _categoriesRepoContract;

  GetCategoryProductsUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryProductsEntity>> call({
    required String categoryId,
    String? sortOption,
    String? keyword,
  }) async {
    final response = await _categoriesRepoContract.getCategoryProducts(
      categoryId: categoryId,
      sortOption: sortOption,
      keyword: keyword,
    );

    return response.when(
      success: (entity) {
        final products = entity.products;
        if (products.isEmpty) return BaseResponse.success(entity);
        final productsWithDiscountPercentage = products
            .map(
              (product) => product.priceAfterDiscount == null
                  ? product
                  : product.copyWith(
                      discountPercentage: _calculateDiscountPercentage(
                        product.price,
                        product.priceAfterDiscount!,
                      ),
                    ),
            )
            .toList();
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
}
