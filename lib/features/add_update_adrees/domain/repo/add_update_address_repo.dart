import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';

abstract interface class AddUpdateAddressRepo {
  Future<BaseResponse<AddUpdateAddressResponseEntity>> addAddress(
    AddUpdateAddressRequestEntity body,
  );
  Future<BaseResponse<AddUpdateAddressResponseEntity>> updateAddress(
    AddUpdateAddressRequestEntity body,
    String id,
  );
}
