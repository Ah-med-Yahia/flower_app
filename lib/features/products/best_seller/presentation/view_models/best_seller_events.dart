sealed class BestSellerEvents {
  const BestSellerEvents();
}

class GetBestSellerProductEvent extends BestSellerEvents {
  const GetBestSellerProductEvent();
}

class NavigateToProductDetailsEvent extends BestSellerEvents {
  final String productId;

  const NavigateToProductDetailsEvent({required this.productId});
}

class NavigateToCartEvent extends BestSellerEvents {
  const NavigateToCartEvent();
}
