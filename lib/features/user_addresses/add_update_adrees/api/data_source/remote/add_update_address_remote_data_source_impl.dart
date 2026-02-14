import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/api/api_clinet/add_update_adrees_api_client.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/data/data_source/remote/add_update_address_remote_data_source.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddUpdateAddressRemoteDataSource)
class AddUpdateAddressRemoteDataSourceImpl
    implements AddUpdateAddressRemoteDataSource {
  final AddUpdateAdreesApiClient _addUpdateAdreesApiClient;

  AddUpdateAddressRemoteDataSourceImpl(this._addUpdateAdreesApiClient);

  @override
  Future<BaseResponse<AddUpdateAddressResponseModel>> addAddress(
    AddUpdateAddressRequestModel body,
  ) {
    return safeApiCall(() => _addUpdateAdreesApiClient.addAddress(body));
  }

  @override
  Future<BaseResponse<AddUpdateAddressResponseModel>> updateAddress(
    AddUpdateAddressRequestModel body,
    String id,
  ) {
    return safeApiCall(() => _addUpdateAdreesApiClient.updateAddress(body, id));
  }
}
