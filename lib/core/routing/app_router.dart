import 'package:go_router/go_router.dart';

import '../../features/product/best_seller/presentation/views/view/best_seller_view.dart';
import '../../home_screen.dart';
import '../constants/app_routes_constants.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.homeRoute,
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
    ],
  );
}
