import 'package:go_router/go_router.dart';

import '../constants/app_routes_constants.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      // Define your routes here
    ],
  );
}
