sealed class NavigationEvents {}

class NavigateToProductDetails extends NavigationEvents {
  final String productId;
  NavigateToProductDetails(this.productId);
}

class NavigateToBestSellerScreen extends NavigationEvents {}

class NavigateToCategoryDetails extends NavigationEvents {
  final String? categoryId;
  NavigateToCategoryDetails(this.categoryId);
}

class NavigateToOccasionDetails extends NavigationEvents {
  final String? occasionId;
  NavigateToOccasionDetails(this.occasionId);
}
