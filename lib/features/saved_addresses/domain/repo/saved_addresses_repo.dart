import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';

abstract interface class SavedAddressesRepo {
  Future<BaseResponse<SavedAddressesResponseEntity>> getSavedAddresses();
  Future<BaseResponse<SavedAddressesResponseEntity>> deleteAddress(String id);
}
