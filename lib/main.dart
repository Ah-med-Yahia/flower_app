import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/bloc_observer/app_bloc_observer.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_asset.dart';
import 'core/constants/app_text_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppTextConstants.enLangKey),
        Locale(AppTextConstants.arLangKey),
      ],
      path: AppAsset.translationsPath,
      startLocale: null, // Let EasyLocalization detect device locale
      fallbackLocale: const Locale(AppTextConstants.enLangKey),
      useOnlyLangCode:
          true, // Use only language code (ar, en) instead of full locale (ar_EG, en_US)
      saveLocale:
          false, // Don't save locale to storage, always follow device locale
      child: const FlowerApp(),
    ),
  );
}
