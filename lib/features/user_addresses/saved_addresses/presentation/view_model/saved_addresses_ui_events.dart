import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';

sealed class SavedAddressesUiEvents {}

class NavigateToAddUpdateAddressUiEvent extends SavedAddressesUiEvents {
  final AddressEntity? address;

  NavigateToAddUpdateAddressUiEvent(this.address);
}
