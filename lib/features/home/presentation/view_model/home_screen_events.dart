sealed class HomeScreenEvents {}

class GetHomeScreenDataEvent extends HomeScreenEvents {}

class WhenBestSellerIsClickedEvent extends HomeScreenEvents {
  final String productId;
  WhenBestSellerIsClickedEvent({required this.productId});
}

class WhenViewAllBestSellerIsClickedEvent extends HomeScreenEvents {}

class WhenCategoryIsClickedEvent extends HomeScreenEvents {
  final String categoryId;
  WhenCategoryIsClickedEvent({required this.categoryId});
}

class WhenCategoryViewAllIsClickedEvent extends HomeScreenEvents {}

class WhenOccasionIsClickedEvent extends HomeScreenEvents {
  final String occasionId;
  WhenOccasionIsClickedEvent({required this.occasionId});
}

class WhenOccasionViewAllIsClickedEvent extends HomeScreenEvents {}

class GetSearchProductsEvent extends HomeScreenEvents {
  final String? keyword;
  GetSearchProductsEvent({this.keyword});
}

class IsSearching extends HomeScreenEvents {
  final bool isSearching;
  IsSearching({required this.isSearching});
}
