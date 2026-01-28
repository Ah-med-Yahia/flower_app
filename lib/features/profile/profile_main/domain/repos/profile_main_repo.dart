import '../../../../../config/base_response/base_response.dart';
import '../../data/models/terms_and_conditions/terms_and_conditions.dart';
import '../entities/user_data_response.dart';

abstract interface class ProfileMainRepo {
  Future<BaseResponse<UserDataResponse>> getLoggedUserData();

  Future<BaseResponse<TermsAndConditions>> getTermsData();
}
