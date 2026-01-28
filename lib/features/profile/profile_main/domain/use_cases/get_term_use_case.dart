import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/terms_and_conditions/terms_and_conditions.dart';
import '../repos/profile_main_repo.dart';

@injectable
class GetTermUseCase {
  final ProfileMainRepo _profileMainRepo;

  GetTermUseCase(this._profileMainRepo);

  Future<BaseResponse<TermsAndConditions>> call() {
    return _profileMainRepo.getTermsData();
  }
}
