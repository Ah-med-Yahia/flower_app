import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_routes_constants.dart';
import 'package:online_exam_app/features/auth/register/presentation/pages/register_screen.dart';
import 'package:online_exam_app/home_screen.dart';

import '../../features/product/best_seller/presentation/views/view/best_seller_view.dart';
import '../../home_screen.dart';
import '../constants/app_routes_constants.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.registerEndpoint,
    routes: [
      // Define your routes here
      GoRoute(
        path: AppRoutesConstants.registerEndpoint,
        name: AppRoutesConstants.registerEndpoint,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.home,
        path: AppRoutesConstants.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.bestSellerRoute,
        name: AppRoutesConstants.bestSellerRoute,
        builder: (context, state) => BestSellerView(),
      ),
    ],
  );
}
