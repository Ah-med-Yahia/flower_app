import 'package:flower_app/features/categories/data/models/get_products_models/category_products_response_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('category products response model to entity', () {
    final model = CategoryProductsResponseModel(
      message: 'Success',
      metadata: CategoryMetadataModel(
        currentPage: 1,
        totalPages: 1,
        limit: 2,
        totalItems: 50,
      ),
      products: [],
    );

    final entity = model.toEntity();

    expect(entity, isA<GetCategoryProductsEntity>());
    expect(entity.products, isA<List<CategoryProductEntity>>());
  });
}
