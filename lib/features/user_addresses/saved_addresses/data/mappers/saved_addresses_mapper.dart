import 'package:flower_app/features/user_addresses/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';

extension SavedAddressesResponseToEntityMapper on SavedAddressesResponseModel {
  SavedAddressesResponseEntity toEntity() {
    return SavedAddressesResponseEntity(
      message: message ?? '',
      addresses: addresses?.map((address) => address.toEntity()).toList() ?? [],
    );
  }
}

extension AddressToEntityMapper on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
