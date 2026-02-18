sealed class CategoriesIntents {}

class GetAllCategories extends CategoriesIntents {
  final String? initialCategoryId;

  GetAllCategories({required this.initialCategoryId});
}

class SelectCategory extends CategoriesIntents {
  final int index;
  SelectCategory(this.index);
}

class SelectSortOption extends CategoriesIntents {
  final String? sortOption;
  SelectSortOption(this.sortOption);
}

class GetCategoryProducts extends CategoriesIntents {
  final String categoryId;
  final String? sortOption;
  final String? keyword;
  GetCategoryProducts(this.categoryId, {this.sortOption, this.keyword});
}

class IsSearching extends CategoriesIntents {
  final bool isSearching;
  IsSearching({required this.isSearching});
}
