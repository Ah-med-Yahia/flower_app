// get_coordinates_from_address_usecase.dart
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCoordinatesFromAddressUseCase {
  final AddUpdateAddressRepo _repo;

  GetCoordinatesFromAddressUseCase(this._repo);

  Future<BaseResponse<LocationEntity>> call({
    required String cityName,
    required String stateName,
  }) async {
    // Validate that at least state name is provided
    if (stateName.isEmpty) {
      return BaseResponse.failure(
        ErrorHandler.handle(
          Exception(ErrorsConstant.cityNameOrStateNameIsRequired),
        ),
      );
    }

    // Call repository to get coordinates
    return await _repo.getCoordinatesFromAddress(
      cityName: cityName,
      stateName: stateName,
    );
  }
}
