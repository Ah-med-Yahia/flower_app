import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/config/services/fcm_services.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_intents.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_side_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late Size screenSize;
  late TextTheme textTheme;
  late SplashCubit splashCubit;

  @override
  void initState() {
    super.initState();

    splashCubit = getIt<SplashCubit>();
    splashCubit.doIntent(const CheckLoginStatusIntent());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _scale = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    splashCubit.sideEffectStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case NavigateToHomeSideEffect():
          _hadleNavigationToHome();
        case NavigateToLoginSideEffect():
          context.pushReplacementNamed(AppRoutesConstants.loginRoute);
        case ErrorSideEffect(message: final message):
          UIUtils.showMessage(
            message,
            backGroundColor: AppColors.red,
            textColor: AppColors.white,
          );
      }
    });
  }

  void _hadleNavigationToHome() {
    if (FCMService.initialNotificationMessage != null) {
      context.pushReplacementNamed(AppRoutesConstants.homeRoute);
      context.pushNamed(AppRoutesConstants.notificationRoute);
      FCMService.initialNotificationMessage = null;
    } else {
      context.pushReplacementNamed(AppRoutesConstants.homeRoute);
    }
  }

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.sizeOf(context);
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: splashCubit,
      child: Scaffold(
        backgroundColor: AppColors.splashBackground,
        body: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: screenSize.height * 0.156,
                    width: screenSize.width * 0.29,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Center(
                      child: Image.asset(
                        Assets.images.flowerLogo.path,
                        height: 56,
                      ),
                    ),
                  ),
                  18.verticalSpacing,
                  Text(
                    AppTextConstants.appName,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: AppColors.secondary,
                    ),
                  ),
                  22.verticalSpacing,
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.secondary,
                      ),
                      backgroundColor: AppColors.secondary.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
