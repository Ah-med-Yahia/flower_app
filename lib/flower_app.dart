import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/routing/app_router.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_text_constants.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        // Localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          if (locale != null) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }
          // Fallback to English if device locale is not supported
          return const Locale(AppTextConstants.enLangKey);
        },
      ),
    );
  }
}
