import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_request_model.dart';
import 'package:flower_app/features/add_update_adrees/data/models/add_update_address_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'add_update_adrees_api_client.g.dart';

@RestApi()
@injectable
abstract class AddUpdateAdreesApiClient {
  @factoryMethod
  factory AddUpdateAdreesApiClient(Dio dio) = _AddUpdateAdreesApiClient;

  @PATCH(ApiConstants.addAddress)
  Future<AddUpdateAddressResponseModel> addAddress(
    @Body() AddUpdateAddressRequestModel body,
  );
  @PATCH(ApiConstants.updateAddress)
  Future<AddUpdateAddressResponseModel> updateAddress(
    @Body() AddUpdateAddressRequestModel body,
    @Path(ApiConstants.idPathQuery) String id,
  );
}
