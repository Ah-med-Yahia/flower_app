import '../../models/terms_and_conditions/terms_and_conditions.dart';

abstract interface class ProfileMainLocalDataSource {
  Future<TermsAndConditions> getTermsData();
}
