import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/api/api_client/saved_addresses_api_client.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/data_sources/remote/saved_addresses_remote_datasource.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SavedAddressesRemoteDatasource)
class SavedAddressesRemoteDatasourceImpl
    implements SavedAddressesRemoteDatasource {
  final SavedAddressesApiClient _apiClient;

  SavedAddressesRemoteDatasourceImpl(this._apiClient);

  @override
  Future<BaseResponse<SavedAddressesResponseModel>> getSavedAddresses() async {
    return safeApiCall(() => _apiClient.getSavedAddresses());
  }

  @override
  Future<BaseResponse<SavedAddressesResponseModel>> deleteAddress(
    String id,
  ) async {
    return safeApiCall(() => _apiClient.deleteAddress(id));
  }
}
