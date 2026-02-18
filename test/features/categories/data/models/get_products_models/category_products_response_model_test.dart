import 'package:flower_app/core/shared/data/mappers/products_response_mapper.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('category products response model to entity', () {
    final model = ProductsResponseModel(
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

    expect(entity, isA<ProductsResponseEntity>());
    expect(entity.products, isA<List<ProductEntity>>());
  });
}
