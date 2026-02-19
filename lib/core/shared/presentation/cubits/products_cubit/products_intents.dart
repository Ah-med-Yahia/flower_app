sealed class ProductsIntents {}

class AddProductToCart extends ProductsIntents {
  final String productId;
  final int quantity;
  AddProductToCart(this.productId, this.quantity);
}

class RemoveProductFromCart extends ProductsIntents {
  final String productId;
  RemoveProductFromCart(this.productId);
}

class GetProducts extends ProductsIntents {
  final String? categoryId;
  final String? occasionId;
  final String? sortOption;
  final String? keyword;
  GetProducts({
    this.categoryId,
    this.occasionId,
    this.sortOption,
    this.keyword,
  });
}

class IsSearching extends ProductsIntents {
  final bool isSearching;
  IsSearching(this.isSearching);
}

class ResetProductsAfterSearch extends ProductsIntents {}

class UpdateCart extends ProductsIntents {}
