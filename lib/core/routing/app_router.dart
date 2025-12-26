import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_routes_constants.dart';
import 'package:online_exam_app/features/auth/register/presentation/pages/register_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.registerScreen,
    routes: [
      GoRoute(
        path: AppRoutesConstants.registerScreen,
        name: AppRoutesConstants.registerScreen,
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}
