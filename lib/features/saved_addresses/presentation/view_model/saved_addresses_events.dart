sealed class SavedAddressesEvent {}

class GetSavedAddressesEvent extends SavedAddressesEvent {}

class DeleteSavedAddressEvent extends SavedAddressesEvent {
  final String addressId;

  DeleteSavedAddressEvent(this.addressId);
}

class EditSavedAddressEvent extends SavedAddressesEvent {
  final String addressId;

  EditSavedAddressEvent(this.addressId);
}

class AddNewAddressEvent extends SavedAddressesEvent {}
