import '../../models/app_app/flowery_about_app_model.dart';
import '../../models/terms_and_conditions/terms_and_conditions.dart';

abstract interface class ProfileMainLocalDataSource {
  Future<TermsAndConditions> getTermsData();

  Future<FloweryAboutAppModel> getAboutAppData();
}
