import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/models/state_entity.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/domain/repo/add_update_address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStatesUescase {
  final AddUpdateAddressRepo _repo;

  GetStatesUescase(this._repo);

  Future<BaseResponse<List<StateEntity>>> call() async {
    return await _repo.getGovernorates();
  }
}
