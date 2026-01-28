import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../features/auth/change_password/presentation/screens/change_password_screen.dart';
import '../../features/auth/forget_password/presentation/views/forget_password_view/forget_password_view.dart';
import '../../features/auth/forget_password/presentation/views/reset_password_view/reset_password_view.dart';
import '../../features/auth/forget_password/presentation/views/verify_otp_view/verify_otp_code_view.dart';
import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import '../../features/auth/register/presentation/pages/register_screen.dart';
import '../../features/occasion/presentation/views/screens/occasion_screen.dart';
import '../../features/product/best_seller/presentation/views/view/best_seller_view.dart';
import '../../features/product_details/presentaion/view/screens/product_details_screen.dart';
import '../../home_screen.dart';
import '../constants/app_routes_constant.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        name: AppRoutesConstants.loginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutesConstants.bestSellerRoute,
        name: AppRoutesConstants.bestSellerRoute,
        builder: (context, state) => const BestSellerView(),
      ),
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        name: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.productDetailsRoute,
        name: AppRoutesConstants.productDetailsRoute,
        builder: (context, state) =>
            ProductDetailsScreen(productId: state.extra as String),
      ),
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        name: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: AppRoutesConstants.verifyOtpRoute,
        name: AppRoutesConstants.verifyOtpRoute,
        builder: (context, state) {
          final email = state.extra is String ? state.extra as String : '';
          return VerifyOtpView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.resetPasswordRoute,
        name: AppRoutesConstants.resetPasswordRoute,
        builder: (context, state) {
          final email = state.extra is String ? state.extra as String : '';
          return ResetPasswordView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.occasionScreen,
        name: AppRoutesConstants.occasionScreen,
        builder: (context, state) => const OccasionScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.changePasswordRoute,
        name: AppRoutesConstants.changePasswordRoute,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
    ],
  );
}
