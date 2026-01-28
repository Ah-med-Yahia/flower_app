sealed class CartEventUI {}

class LoadingCart extends CartEventUI {}  

class Error extends CartEventUI {
  final String message;

  Error({required this.message});
}

class SuccessClearCart extends CartEventUI {
  final String message;

  SuccessClearCart({required this.message});
}