import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentLocationUsecase {
  final AddUpdateAddressRepo _repo;

  GetCurrentLocationUsecase(this._repo);

  Future<BaseResponse<LocationEntity>> call() async {
    return await _repo.getCurrentLocation();
  }
}
