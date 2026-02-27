sealed class CartEventUI {}

class LoadingCart extends CartEventUI {}

class ErrorGetCart extends CartEventUI {
  final String message;

  ErrorGetCart({required this.message});
}

class ErrorCartItemsUpdate extends CartEventUI {
  final String message;

  ErrorCartItemsUpdate({required this.message});
}

class SuccessAfterLoading extends CartEventUI {
  final String? message;

  SuccessAfterLoading({this.message});
}

class LogoutUser extends CartEventUI {}
