import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/routing/app_routes_constant.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        name: AppRoutesConstants.loginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child:const LoginScreen(),
        ),
      ),
    ],
  );
}
