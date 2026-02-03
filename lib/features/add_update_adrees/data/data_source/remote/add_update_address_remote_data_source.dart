import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';

abstract interface class AddUpdateAddressRemoteDataSource {
  Future<BaseResponse<AddUpdateAddressResponseModel>> addAddress(
    AddUpdateAddressRequestModel body,
  );

  Future<BaseResponse<AddUpdateAddressResponseModel>> updateAddress(
    AddUpdateAddressRequestModel body,
    String id,
  );
}
