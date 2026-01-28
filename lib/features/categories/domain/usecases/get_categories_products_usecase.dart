import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/categories/domain/repos/categories_repo_contract.dart';

@injectable
class GetCategoryProductsUsecase {
  final CategoriesRepoContract _categoriesRepoContract;

  GetCategoryProductsUsecase(this._categoriesRepoContract);

  Future<BaseResponse<GetCategoryProductsEntity>> getCategoryProducts(
    String categoryId,
  ) async {
    final response = await _categoriesRepoContract.getCategoryProducts(
      categoryId,
    );

    return response.when(
      success: (entity) {
        final product = entity.products;
        if (product == null) return BaseResponse.success(entity);

        final discount = _calculateDiscountPercentage(
          product.price,
          product.priceAfterDiscount,
        );

        final updatedProduct = product.copyWith(discountPercentage: discount);

        return BaseResponse.success(entity.copyWith(products: updatedProduct));
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }

  int _calculateDiscountPercentage(num price, num afterDiscount) {
    if (price <= 0) return 0;
    if (afterDiscount >= price) return 0;

    return (((price - afterDiscount) / price) * 100).round();
  }
}
