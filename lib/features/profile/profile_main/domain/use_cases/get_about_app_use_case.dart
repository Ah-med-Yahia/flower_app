import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/about_app_entity.dart';
import '../repos/profile_main_repo.dart';

@injectable
class GetAboutAppUseCase {
  final ProfileMainRepo _repo;

  GetAboutAppUseCase(this._repo);

  Future<BaseResponse<AboutAppEntity>> call() {
    return _repo.getAboutAppData();
  }
}
