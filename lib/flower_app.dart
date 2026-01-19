import 'package:flower_app/core/routing/app_router.dart';
import 'package:flower_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.appTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
