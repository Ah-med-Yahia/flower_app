import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/widgets/spacing.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/validators/app_validators.dart';
import '../../view_models/reset_password/reset_password_cubit.dart';
import '../../view_models/reset_password/reset_password_events.dart';
import '../../view_models/reset_password/reset_password_state.dart';
import '../shared_widgets/custom_edit_text_widget.dart';
import '../shared_widgets/custom_elevated_button_widget.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({
    super.key,
    required this.cubit,
    required this.email,
  });

  final ResetPasswordCubit cubit;
  final String email;

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final GlobalKey<FormState> _formKey;
  StreamSubscription<ResetPasswordEvents>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _listenToNavigationEvents();
  }

  void _listenToNavigationEvents() {
    _eventsSubscription = widget.cubit.eventsStream.listen((event) {
      if (!mounted) return;
      if (event is NavigateToLogin) {
        _navigateToLoginScreen();
      }
    });
  }

  void _navigateToLoginScreen() {
    const String loginRoute = '/login';
    GoRouter.of(context).go(loginRoute);
    debugPrint('Navigate to Login Screen');
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;
      if (newPassword != confirmPassword) {
        // ToastUtils.showErrorToast(
        //   context,
        //   ValidationConstants.passwordsDoNotMatch,
        // );
        return;
      }
      widget.cubit.doIntent(
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
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              32.verticalSpacing,
              // New Password INPUT FIELD
              // TODO: Handle new password input field and Confirm Password input field
              CustomEditTextWidget(
                edtTxtController: _newPasswordController,
                keyboardType: TextInputType.text,
                isEnabled: !state.resetPasswordState.isLoading,
                labelText: AppTextConstants.newPasswordLabel,
                hintText: AppTextConstants.newPasswordHint,
                focusErrorText: '',
                validator: _validateNewPassword,
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
              ),
              48.verticalSpacing,
              CustomElevatedButtonWidget(onPressed: _handleSubmit),
            ],
          ),
        );
      },
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
