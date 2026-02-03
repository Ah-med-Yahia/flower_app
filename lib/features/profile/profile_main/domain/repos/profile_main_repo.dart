import '../../../../../config/base_response/base_response.dart';
import '../entities/term_section_entity.dart';
import '../entities/user_data_response.dart';

abstract interface class ProfileMainRepo {
  Future<BaseResponse<UserDataResponse>> getLoggedUserData();

  Future<BaseResponse<List<TermSectionEntity>>> getTermsData();

  Future<BaseResponse<List<TermSectionEntity>>> getAboutAppData();
}
