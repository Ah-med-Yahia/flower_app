import '../../../../../config/base_response/base_response.dart';
import '../entities/about_app_entity.dart';
import '../entities/term_section_entity.dart';
import '../entities/user_data_response.dart';

abstract interface class ProfileMainRepo {
  Future<BaseResponse<UserDataResponse>> getLoggedUserData();

  Future<BaseResponse<TermsAndConditionsEntity>> getTermsData();

  Future<BaseResponse<AboutAppEntity>> getAboutAppData();
}
