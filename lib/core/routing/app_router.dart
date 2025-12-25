import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/home_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppReoutesConstants.initialLocation,
    routes: [
      GoRoute(
        path: AppReoutesConstants.initialLocation,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
