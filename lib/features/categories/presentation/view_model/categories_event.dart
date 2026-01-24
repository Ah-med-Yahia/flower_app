sealed class CategoriesEvent {}

class GetAllCategories extends CategoriesEvent {}

class SelectCategory extends CategoriesEvent {
  final int index;
  SelectCategory(this.index);
}

class GetCategoryProducts extends CategoriesEvent {
  final String categoryId;
  GetCategoryProducts(this.categoryId);
}
