sealed class CategoriesEvent {}

class GetAllCategories extends CategoriesEvent {
  final String? initialCategoryId;

  GetAllCategories({required this.initialCategoryId});
}

class SelectCategory extends CategoriesEvent {
  final int index;
  SelectCategory(this.index);
}

class GetCategoryProducts extends CategoriesEvent {
  final String categoryId;
  GetCategoryProducts(this.categoryId);
}
