import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/features/product_details/presentaion/view/screens/product_details_screen.dart';
import 'package:online_exam_app/home_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppReoutesConstants.initialLocation,
    routes: [
      GoRoute(
        path: AppReoutesConstants.initialLocation,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppReoutesConstants.productDetailsRoute,
        builder: (context, state) =>
            ProductDetailsScreen(productId: state.extra as String),
      ),
    ],
  );
}
