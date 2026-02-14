import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';

abstract interface class SavedAddressesRepo {
  Future<BaseResponse<SavedAddressesResponseEntity>> getSavedAddresses();
  Future<BaseResponse<SavedAddressesResponseEntity>> deleteAddress(String id);
}
