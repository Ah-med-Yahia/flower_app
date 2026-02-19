sealed class ProductDetailsEvents {}

class GetProductDetailsEvent extends ProductDetailsEvents {
  final String productId;

  GetProductDetailsEvent(this.productId);
}
