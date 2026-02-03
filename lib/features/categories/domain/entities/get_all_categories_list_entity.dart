import 'package:flower_app/features/categories/domain/entities/category_entity.dart';

class GetCategoryListEntity {
  final List<CategoryEntity>? categories;

  GetCategoryListEntity({required this.categories});
}
