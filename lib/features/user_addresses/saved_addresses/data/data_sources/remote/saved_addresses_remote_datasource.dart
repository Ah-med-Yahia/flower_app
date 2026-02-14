import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/models/saved_addresses_response_model.dart';

abstract interface class SavedAddressesRemoteDatasource {
  Future<BaseResponse<SavedAddressesResponseModel>> getSavedAddresses();
  Future<BaseResponse<SavedAddressesResponseModel>> deleteAddress(String id);
}
