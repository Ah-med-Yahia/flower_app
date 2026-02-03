import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/city_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesByStateUseCase {
  final AddUpdateAddressRepo _repo;

  GetCitiesByStateUseCase(this._repo);

  Future<BaseResponse<List<CityEntity>>> call(String governorateId) async {
    final response = await _repo.getCities();

    return response.when(
      success: (cities) {
        final filteredCities = cities
            .where((city) => city.governorateId == governorateId)
            .toList();
        return BaseResponse.success(filteredCities);
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
