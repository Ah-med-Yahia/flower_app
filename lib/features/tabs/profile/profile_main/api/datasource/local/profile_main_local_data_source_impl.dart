import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/constants/app_asset.dart';
import '../../../data/datasource/local/profile_main_local_data_source.dart';
import '../../../data/models/app_app/flowery_about_app_model.dart';
import '../../../data/models/terms_and_conditions/terms_and_conditions.dart';

@Injectable(as: ProfileMainLocalDataSource)
class ProfileMainLocalDataSourceImpl implements ProfileMainLocalDataSource {
  @override
  Future<TermsAndConditions> getTermsData() async {
    final jsonString = await rootBundle.loadString(
      AppAsset.termsAndConditionsPath,
    );
    return TermsAndConditions.fromJsonString(jsonString);
  }

  @override
  Future<FloweryAboutAppModel> getAboutAppData() async {
    final jsonString = await rootBundle.loadString(AppAsset.aboutAppPath);
    return FloweryAboutAppModel.fromJsonString(jsonString);
  }
}
