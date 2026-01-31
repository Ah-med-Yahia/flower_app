import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';

// ==================== Request Mapping: Entity → Model ====================

extension AddUpdateAddressRequestToModelMapper
    on AddUpdateAddressRequestEntity {
  AddUpdateAddressRequestModel toModel() {
    return AddUpdateAddressRequestModel(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }
}

// ==================== Response Mapping: Model → Entity ====================

extension AddUpdateAddressResponseToEntityMapper
    on AddUpdateAddressResponseModel {
  AddUpdateAddressResponseEntity toEntity() {
    return AddUpdateAddressResponseEntity(
      message: message ?? '',
      address: address?.map((model) => model.toEntity()).toList() ?? [],
    );
  }
}

extension AddressModelToEntityMapper on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
      id: id ?? '',
      street: street ?? '',
      phone: phone ?? '',
      city: city ?? '',
      lat: lat ?? '',
      long: long ?? '',
      username: username ?? '',
    );
  }
}
