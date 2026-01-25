sealed class UIEvents {}

class NavigateToProductDetailsEvent extends UIEvents {
  final String productId;
  NavigateToProductDetailsEvent(this.productId);
}

class NavigateToBestSellerScreenEvent extends UIEvents {}

class NavigateToCategoryEvent extends UIEvents {
  final String? categoryId;
  NavigateToCategoryEvent(this.categoryId);
}

class NavigateToOccasionEvent extends UIEvents {
  final String? occasionId;
  NavigateToOccasionEvent(this.occasionId);
}
