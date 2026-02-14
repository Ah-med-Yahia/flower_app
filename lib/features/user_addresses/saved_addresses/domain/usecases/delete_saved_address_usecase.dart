import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/domain/repo/saved_addresses_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteSavedAddressUsecase {
  final SavedAddressesRepo _repo;

  DeleteSavedAddressUsecase(this._repo);

  Future<BaseResponse<SavedAddressesResponseEntity>> call(String id) async {
    return await _repo.deleteAddress(id);
  }
}
