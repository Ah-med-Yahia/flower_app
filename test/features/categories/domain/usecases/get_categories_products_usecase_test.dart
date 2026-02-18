import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/categories/data/repos/categories_repo_impl.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/features/categories/domain/usecases/get_categories_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_categories_products_usecase_test.mocks.dart';

@GenerateMocks([CategoriesRepoImpl])
void main() {
  group('get categories products usecase', () {
    late MockCategoriesRepoImpl categoriesRepoImpl;
    late GetCategoryProductsUsecase getCategoryProductsUsecase;

    ProductEntity makeProductEntity({
      double? priceAfterDiscount,
      double? discount,
    }) {
      return ProductEntity(
        id: '1',
        title: 'name',
        description: 'description',
        price: 10,
        priceAfterDiscount: priceAfterDiscount,
        discount: discount,
        categoryId: '1',
        occasionId: '1',
        quantity: 1,
      );
    }

    setUp(() {
      categoriesRepoImpl = MockCategoriesRepoImpl();
      getCategoryProductsUsecase = GetCategoryProductsUsecase(
        categoriesRepoImpl,
      );
    });
    test('get categories products usecase success case', () async {
      when(categoriesRepoImpl.getCategoryProducts(categoryId: '1')).thenAnswer(
        (_) async => BaseResponse.success(
          ProductsResponseEntity(
            products: [
              makeProductEntity(),
              makeProductEntity(priceAfterDiscount: 5),
            ],
          ),
        ),
      );
      final result = await getCategoryProductsUsecase(categoryId: '1');
      expect(result, isA<Success<ProductsResponseEntity>>());
      result as Success<ProductsResponseEntity>;
      expect(result.data.products.length, 2);
      expect(result.data.products[0].priceAfterDiscount, isNull);
      expect(result.data.products[0].discountPercentage, isNull);
      expect(result.data.products[1].discountPercentage, '50%');
    });
    test('get categories products usecase failure case', () async {
      when(categoriesRepoImpl.getCategoryProducts(categoryId: '1')).thenAnswer(
        (_) async =>
            BaseResponse.failure(ErrorHandler.handle(Exception('Error'))),
      );
      final result = await getCategoryProductsUsecase(categoryId: '1');
      expect(result, isA<Failure<ProductsResponseEntity>>());
      result as Failure<ProductsResponseEntity>;
      expect(result.errorHandler.message, ErrorsConstant.defaultError);
    });
  });
}
