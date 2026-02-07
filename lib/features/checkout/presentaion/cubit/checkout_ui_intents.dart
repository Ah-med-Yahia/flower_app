sealed class CheckoutUiIntents {
  const CheckoutUiIntents();
}

class ShowLoadingIntent extends CheckoutUiIntents {}

class HideLoadingIntent extends CheckoutUiIntents {}

class ShowErrorIntent extends CheckoutUiIntents {
  final String message;
  const ShowErrorIntent({required this.message});
}

class NavigateToSuccessIntent extends CheckoutUiIntents {
  final String message;
  const NavigateToSuccessIntent({required this.message});
}

class NavigateToWebviewIntent extends CheckoutUiIntents {
  final String url;
  const NavigateToWebviewIntent({required this.url});
}

class NavigateToEditAddressIntent extends CheckoutUiIntents {
  final String addressId;
  const NavigateToEditAddressIntent({required this.addressId});
}

class NavigateToNewAddressIntent extends CheckoutUiIntents {}
