import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/app_routes_constant.dart';
import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/ui_utils/ui_utils.dart';
import '../../view_models/profile_main_cubit.dart';
import '../../view_models/profile_main_intents.dart';
import '../../view_models/profile_main_side_effects.dart';
import '../../view_models/profile_main_states.dart';
import '../widget/custom_bottom_sheet_widget.dart';
import '../widget/language_and_policies_section.dart';
import '../widget/logout_section.dart';
import '../widget/order_and_address_section.dart';
import '../widget/user_data_section.dart';

class ProfileMainBody extends StatefulWidget {
  const ProfileMainBody({super.key});

  @override
  State<ProfileMainBody> createState() => _ProfileMainBodyState();
}

class _ProfileMainBodyState extends State<ProfileMainBody> {
  late ProfileMainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProfileMainCubit>();
    // Send intent to load user data - proper MVI pattern

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.doIntent(GetUserDataIntent());
    });
  }

  void handleSideEffect(
    BuildContext context,
    ProfileMainSideEffects sideEffect,
  ) {
    switch (sideEffect) {
      case ShowErrorSideEffect():
        _showErrorMessage(sideEffect.message);
      case NavigateToLoginSideEffect():
        _navigateToLogin(context);
      case ShowLanguageBottomSheetSideEffect():
        _showLanguageBottomSheet(context);
      case NavigateToEditProfileSideEffect():
        _navigateToEditProfile(context);
      case ShowAlertDialogSideEffect():
        _showAlertDialog();
      case NavigateToAppPolicySideEffect():
        _navigateToPolicy(context);
      case NavigateToAppInformationSideEffect():
        _navigateToAboutUs(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileMainSideEffects>(
      stream: context.read<ProfileMainCubit>().sideEffects,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            handleSideEffect(context, asyncSnapshot.data!);
          });
        }
        return BlocBuilder<ProfileMainCubit, ProfileMainStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const UserDataSection(),
                  const OrderAndAddressSection(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ProfileCardItem(
                      title: AppTextConstants.notification,
                      showIcon: false,
                      leadingWidget: Switch(
                        activeThumbColor: AppColors.background,
                        activeTrackColor: AppColors.secondary,
                        value: state.isNotificationsEnabled,
                        onChanged: (bool value) {
                          // Send intent - proper MVI pattern
                          cubit.doIntent(NotificationToggledIntent());
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  const LanguageAndPoliciesSection(),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      _showAlertDialog();
                    },
                    child: const LogoutSection(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showErrorMessage(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.background,
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CustomBottomSheetWidget(),
      backgroundColor: AppColors.background,
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppTextConstants.logout.toUpperCase()),
        content: Text(AppTextConstants.confirmLogout),
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: Text(AppTextConstants.cancel),
          ),
          TextButton(
            onPressed: () {
              cubit.doIntent(LogoutIntent());
            },
            child: Text(AppTextConstants.logout),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    GoRouter.of(context).pushReplacementNamed(AppRoutesConstants.loginRoute);
  }

  void _navigateToPolicy(BuildContext context) {
    GoRouter.of(context).pushNamed(AppRoutesConstants.appPolicyRoute);
  }

  void _navigateToAboutUs(BuildContext context) {
    GoRouter.of(context).pushNamed(AppRoutesConstants.appInfoRoute);
  }

  void _navigateToEditProfile(BuildContext context) {
    final userData = cubit.state.userData.data;
    GoRouter.of(
      context,
    ).pushNamed(AppRoutesConstants.editProfileRoute, extra: userData);
  }
}
