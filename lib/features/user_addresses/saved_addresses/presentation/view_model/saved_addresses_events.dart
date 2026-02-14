import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';

sealed class SavedAddressesEvent {}

class GetSavedAddressesEvent extends SavedAddressesEvent {}

class DeleteSavedAddressEvent extends SavedAddressesEvent {
  final String addressId;

  DeleteSavedAddressEvent(this.addressId);
}

class EditSavedAddressEvent extends SavedAddressesEvent {
  final AddressEntity address;

  EditSavedAddressEvent(this.address);
}

class AddNewAddressEvent extends SavedAddressesEvent {}
