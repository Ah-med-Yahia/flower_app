import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/bloc_observer/app_bloc_observer.dart';
import 'package:flower_app/config/services/fcm_services.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_asset.dart';
import 'core/constants/app_text_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await FCMService().getToken();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
