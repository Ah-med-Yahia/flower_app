import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/term_section_entity.dart';
import '../repos/profile_main_repo.dart';

@injectable
class GetTermUseCase {
  final ProfileMainRepo _profileMainRepo;

  GetTermUseCase(this._profileMainRepo);

  Future<BaseResponse<List<TermSectionEntity>>> call() {
    return _profileMainRepo.getTermsData();
  }
}
