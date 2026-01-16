import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
