import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/state_entity.dart';

abstract interface class AddUpdateAddressRepo {
  Future<BaseResponse<LocationEntity>> getCurrentLocation();
  Future<BaseResponse<AddUpdateAddressResponseEntity>> addAddress(
    AddUpdateAddressRequestEntity body,
  );

  Future<BaseResponse<AddUpdateAddressResponseEntity>> updateAddress(
    AddUpdateAddressRequestEntity body,
    String id,
  );
  Future<BaseResponse<List<StateEntity>>> getGovernorates();
  Future<BaseResponse<List<CityEntity>>> getCities();
  Future<BaseResponse<LocationEntity>> getCoordinatesFromAddress({
    required String cityName,
    required String stateName,
  });
}
