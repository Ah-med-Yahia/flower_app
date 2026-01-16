import 'package:go_router/go_router.dart';

import '../../features/product/best_seller/presentation/views/view/best_seller_view.dart';
import '../../home_screen.dart';
import '../../features/auth/forget_password/presentation/views/forget_password_view/forget_password_view.dart';
import '../../features/auth/forget_password/presentation/views/reset_password_view/reset_password_view.dart';
import '../../features/auth/forget_password/presentation/views/verify_otp_view/verify_otp_code_view.dart';
import '../constants/app_routes_constants.dart';

abstract class AppRouter {

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.homeRoute,
    //initialLocation: AppRoutesConstants.forgetPasswordRoute,
    routes: [
      // Define your routes here
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.bestSellerRoute,
        name: AppRoutesConstants.bestSellerRoute,
        builder: (context, state) => BestSellerView(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: AppRoutesConstants.verifyOtpRoute,
        name: AppRoutesConstants.verifyOtpRoute,
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyOtpView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.resetPasswordRoute,
        name: AppRoutesConstants.resetPasswordRoute,
        builder: (context, state) {
          final email = state.extra as String;
          return ResetPasswordView(email: email);
        },
      ),
    ],
  );
}
