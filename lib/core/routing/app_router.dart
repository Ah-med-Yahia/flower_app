import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/home_screen.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/features/occasion/presentation/views/screens/occasion_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.occasionScreen,
    routes: [
      GoRoute(
        path: AppRoutesConstants.initialLocation,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.occasionScreen,
        builder: (context, state) => OccasionScreen(),
      ),
    ],
  );
}
