import 'package:flower_app/features/categories/domain/entities/get_category_list_entity/category_entity.dart';

class GetCategoryListEntity {
  final List<CategoryEntity>? categories;

  GetCategoryListEntity({required this.categories});
}
