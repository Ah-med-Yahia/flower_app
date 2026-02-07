import 'package:flower_app/features/categories/data/models/get_products_models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Product model to entity', () {
    final model = ProductModel(
      id: '1',
      title: 'Product 1',
      description: 'Description 1',
      price: 10.0,
      category: 'Category 1',
      occasion: 'Occasion 1',
    );

    final entity = model.toEntity();

    expect(entity.id, '1');
    expect(entity.title, 'Product 1');
    expect(entity.description, 'Description 1');
    expect(entity.price, 10.0);
    expect(entity.categoryId, 'Category 1');
    expect(entity.occasionId, 'Occasion 1');
  });
}
