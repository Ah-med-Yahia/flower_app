import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/features/occasion/presentation/views/screens/occasion_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppReoutesConstants.occasionScreen,
        builder: (context, state) => OccasionScreen(),
      ),
    ],
  );
}
