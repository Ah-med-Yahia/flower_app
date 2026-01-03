import 'package:go_router/go_router.dart';
import '../../features/product/best_seller/presentation/views/view/best_seller_view.dart';
import '../constants/app_routes_constants.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.initialLocation,
    routes: [
      // Define your routes here
      GoRoute(
        path: AppRoutesConstants.initialLocation,
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
