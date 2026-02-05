import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/saved_addresses/data/models/saved_addresses_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'saved_addresses_api_client.g.dart';

@RestApi()
@injectable
abstract class SavedAddressesApiClient {
  @factoryMethod
  factory SavedAddressesApiClient(Dio dio) => _SavedAddressesApiClient(dio);

  @GET(ApiConstants.savedAddresses)
  Future<SavedAddressesResponseModel> getSavedAddresses();

  @DELETE(ApiConstants.deleteAddress)
  Future<SavedAddressesResponseModel> deleteAddress(
    @Path(ApiConstants.idPathQuery) String id,
  );
}
