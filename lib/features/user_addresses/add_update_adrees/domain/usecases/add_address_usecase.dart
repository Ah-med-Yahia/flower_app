import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUsecase {
  final AddUpdateAddressRepo _repo;

  AddAddressUsecase(this._repo);

  Future<BaseResponse<AddUpdateAddressResponseEntity>> call(
    AddUpdateAddressRequestEntity addUpdateAddressRequestEntity,
  ) async {
    return await _repo.addAddress(addUpdateAddressRequestEntity);
  }
}
