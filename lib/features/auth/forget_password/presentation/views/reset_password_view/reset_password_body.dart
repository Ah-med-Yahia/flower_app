import 'dart:async';

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/validators/app_validators.dart';
import '../../../../../../core/constants/app_routes_constant.dart';
import '../../../../../../core/constants/validation_constants.dart';
import '../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../view_models/reset_password/reset_password_cubit.dart';
import '../../view_models/reset_password/reset_password_events.dart';
import '../../view_models/reset_password/reset_password_state.dart';
import '../shared_widgets/custom_edit_text_widget.dart';
import '../shared_widgets/custom_elevated_button_widget.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  late final ResetPasswordCubit cubit;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final GlobalKey<FormState> _formKey;
  StreamSubscription<ResetPasswordEvents>? _eventsSubscription;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ResetPasswordCubit>();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _listenToNavigationEvents();
  }

  void _listenToNavigationEvents() {
    _eventsSubscription = cubit.eventsStream.listen((event) {
      if (!mounted) return;
      if (event is NavigateToLogin) {
        _navigateToLoginScreen();
      }
    });
  }

  void _navigateToLoginScreen() {
    GoRouter.of(context).goNamed(AppRoutesConstants.loginRoute);
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ValidationConstants.passwordsDoNotMatch)),
        );
        return;
      }
      cubit.doIntent(
        ResetPasswordEvent(email: widget.email, newPassword: newPassword),
      );
    }
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.resetPasswordState.errorMessage == null &&
            state.resetPasswordState.isLoading == false) {
          UIUtils.showMessage(
            state.resetPasswordState.data!.message,
            backGroundColor: AppColors.darkGreen,
            textColor: AppColors.white,
          );
        }
      },
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        bloc: cubit,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                32.verticalSpacing,
                // New Password INPUT FIELD
                CustomEditTextWidget(
                  edtTxtController: _newPasswordController,
                  keyboardType: TextInputType.text,
                  isEnabled: !state.resetPasswordState.isLoading,
                  labelText: AppTextConstants.newPasswordLabel,
                  hintText: AppTextConstants.newPasswordHint,
                  focusErrorText: '',
                  validator: _validateNewPassword,
                  isPassword: !_isNewPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    }),
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                24.verticalSpacing,
                // Confirm Password INPUT FIELD
                CustomEditTextWidget(
                  edtTxtController: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  isEnabled: !state.resetPasswordState.isLoading,
                  labelText: AppTextConstants.confirmPasswordLabel,
                  hintText: AppTextConstants.confirmPasswordLabel,
                  focusErrorText: '',
                  validator: _validateConfirmPassword,
                  isPassword: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    }),
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                48.verticalSpacing,
                CustomElevatedButtonWidget(onPressed: _handleSubmit),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _validateNewPassword(String? currentValue) {
    return AppValidators.validatePassword(currentValue ?? '');
  }

  String? _validateConfirmPassword(String? currentValue) {
    final originalValue = _newPasswordController.text;
    return AppValidators.validateConfirmPassword(
      currentValue ?? '',
      originalValue,
    );
  }
}
