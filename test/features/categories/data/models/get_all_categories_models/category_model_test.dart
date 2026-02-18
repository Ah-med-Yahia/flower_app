import 'package:flower_app/features/tabs/categories/data/models/get_all_categories_models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('category model to entity', () {
    final model = CategoryModel(id: '1', name: 'Category 1');

    final entity = model.toEntity();

    expect(entity.id, '1');
    expect(entity.name, 'Category 1');
  });
}
