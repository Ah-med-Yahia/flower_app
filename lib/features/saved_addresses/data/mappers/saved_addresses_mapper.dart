import 'package:flower_app/features/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';

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
