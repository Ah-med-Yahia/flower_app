import 'package:flower_app/features/categories/data/models/get_all_categories_models/get_all_categories_response_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/category_entity.dart';
import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/get_all_categories_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get all categories response model to entity', () {
    final model = GetAllCategoriesResponseModel(
      message: 'Success',
      metadata: CategoryMetadataModel(
        currentPage: 1,
        totalPages: 1,
        limit: 2,
        totalItems: 50,
      ),
      categories: [],
    );

    final entity = model.toEntity();

    expect(entity, isA<GetCategoryListEntity>());
    expect(entity.categories, isA<List<CategoryEntity>>());
  });
}
