import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/features/checkout/presentaion/view/screens/success_checkout_screen.dart';
import 'package:flower_app/features/orders/presentation/views/screens/orders_screen.dart';
import 'package:flower_app/features/user_addresses/add_update_adrees/presentation/view/screens/add_update_address_screen.dart';
import 'package:flower_app/features/user_addresses/shared/domain/models/address_entities.dart';
import 'package:flower_app/features/tabs/profile/change_password/presentation/screens/change_password_screen.dart';
import 'package:flower_app/features/tabs/profile/edit_profile/presentation/views/view/edit_profile_view.dart';
import 'package:flower_app/features/auth/forget_password/presentation/views/forget_password_view/forget_password_view.dart';
import 'package:flower_app/features/auth/forget_password/presentation/views/reset_password_view/reset_password_view.dart';
import 'package:flower_app/features/auth/forget_password/presentation/views/verify_otp_view/verify_otp_code_view.dart';
import 'package:flower_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:flower_app/features/auth/register/presentation/pages/register_screen.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/view/screens/checkout_screen.dart';
import 'package:flower_app/features/products/occasion/presentation/views/screens/occasion_screen.dart';
import 'package:flower_app/features/products/best_seller/presentation/views/view/best_seller_view.dart';
import 'package:flower_app/features/products/product_details/presentaion/view/screens/product_details_screen.dart';
import 'package:flower_app/features/tabs/profile/profile_main/domain/entities/user_data_response.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/terms/view/about_app_view.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/terms/view/terms_view.dart';
import 'package:flower_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flower_app/features/user_addresses/saved_addresses/presentation/view/screens/saved_addresses_screen.dart';
import 'package:flower_app/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppRoutesConstants.splashRoute,
        name: AppRoutesConstants.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.loginRoute,
        name: AppRoutesConstants.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.bestSellerRoute,
        name: AppRoutesConstants.bestSellerRoute,
        builder: (context, state) => const BestSellerView(),
      ),
      GoRoute(
        path: AppRoutesConstants.homeRoute,
        name: AppRoutesConstants.homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.ordersRoute,
        name: AppRoutesConstants.ordersRoute,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.productDetailsRoute,
        name: AppRoutesConstants.productDetailsRoute,
        builder: (context, state) =>
            ProductDetailsScreen(productId: state.extra as String),
      ),
      GoRoute(
        path: AppRoutesConstants.registerRoute,
        name: AppRoutesConstants.registerRoute,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.forgetPasswordRoute,
        name: AppRoutesConstants.forgetPasswordRoute,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: AppRoutesConstants.verifyOtpRoute,
        name: AppRoutesConstants.verifyOtpRoute,
        builder: (context, state) {
          final email = state.extra is String ? state.extra as String : '';
          return VerifyOtpView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.resetPasswordRoute,
        name: AppRoutesConstants.resetPasswordRoute,
        builder: (context, state) {
          final email = state.extra is String ? state.extra as String : '';
          return ResetPasswordView(email: email);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.occasionScreen,
        name: AppRoutesConstants.occasionScreen,
        builder: (context, state) {
          final id = state.extra as String?;
          return OccasionScreen(id: id);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.changePasswordRoute,
        name: AppRoutesConstants.changePasswordRoute,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.checkoutScreen,
        name: AppRoutesConstants.checkoutScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CheckoutCubit>(),
          child: const CheckoutScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutesConstants.appPolicyRoute,
        name: AppRoutesConstants.appPolicyRoute,
        builder: (context, state) => const TermsView(),
      ),
      GoRoute(
        path: AppRoutesConstants.appInfoRoute,
        name: AppRoutesConstants.appInfoRoute,
        builder: (context, state) => const AboutAppView(),
      ),
      GoRoute(
        path: AppRoutesConstants.addUpdateAddressRoute,
        name: AppRoutesConstants.addUpdateAddressRoute,
        builder: (context, state) {
          final address = state.extra as AddressEntity?;
          return AddUpdateAddressScreen(address: address);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.savedAddressesRoute,
        name: AppRoutesConstants.savedAddressesRoute,
        builder: (context, state) => const SavedAddressesScreen(),
      ),
      GoRoute(
        path: AppRoutesConstants.editProfileRoute,
        name: AppRoutesConstants.editProfileRoute,
        builder: (context, state) {
          final userData = state.extra as UserDataResponse;
          return EditProfileView(userData: userData);
        },
      ),
      GoRoute(
        path: AppRoutesConstants.successRoute,
        name: AppRoutesConstants.successRoute,
        builder: (context, state) => const SuccessCheckOutScreen(),
      ),
    ],
  );
}
