sealed class SavedAddressesUiEvents {}

class NavigateToAddUpdateAddressUiEvent extends SavedAddressesUiEvents {
  final String? addressId;

  NavigateToAddUpdateAddressUiEvent(this.addressId);
}
