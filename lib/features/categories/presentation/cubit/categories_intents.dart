sealed class CategoriesIntents {}

class GetAllCategories extends CategoriesIntents {
  final String? initialCategoryId;

  GetAllCategories({required this.initialCategoryId});
}

class SelectCategory extends CategoriesIntents {
  final int index;
  SelectCategory(this.index);
}

class GetCategoryProducts extends CategoriesIntents {
  final String categoryId;
  GetCategoryProducts(this.categoryId);
}
