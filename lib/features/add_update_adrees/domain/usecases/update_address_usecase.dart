import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_request_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/add_update_address_response_entity.dart';
import 'package:flower_app/features/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUsecase {
  final AddUpdateAddressRepo _repo;

  UpdateAddressUsecase(this._repo);

  Future<BaseResponse<AddUpdateAddressResponseEntity>> call(
    AddUpdateAddressRequestEntity addUpdateAddressRequestEntity,
    String id,
  ) async {
    return await _repo.updateAddress(addUpdateAddressRequestEntity, id);
  }
}
