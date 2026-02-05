import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart';
import 'package:flower_app/features/saved_addresses/domain/repo/saved_addresses_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllSavedAddressesUsecase {
  final SavedAddressesRepo _repo;

  GetAllSavedAddressesUsecase(this._repo);

  Future<BaseResponse<SavedAddressesResponseEntity>> call() async {
    return await _repo.getSavedAddresses();
  }
}
