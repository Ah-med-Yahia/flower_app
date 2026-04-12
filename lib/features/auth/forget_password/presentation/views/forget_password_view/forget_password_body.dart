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
import '../../view_models/forget_password/forget_password_cubit.dart';
import '../../view_models/forget_password/forget_password_events.dart';
import '../../view_models/forget_password/forget_password_state.dart';
import '../shared_widgets/custom_edit_text_widget.dart';
import '../shared_widgets/custom_elevated_button_widget.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late final ForgetPasswordCubit cubit;
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;
  StreamSubscription<ForgetPasswordEvents>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ForgetPasswordCubit>();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _listenToNavigationEvents();
  }

  void _listenToNavigationEvents() {
    _eventsSubscription = cubit.eventsStream.listen((event) {
      if (!mounted) return;
      if (event is NavigateToVerifyOtpCode) {
        _navigateToVerifyOtp(event.email);
      }
    });
  }

  void _navigateToVerifyOtp(String email) {
    GoRouter.of(context).push(AppRoutesConstants.verifyOtpRoute, extra: email);
    debugPrint('Navigate to verify OTP with email: $email');
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      cubit.doIntent(ForgetPasswordEvent(email: email));
    }
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.forgetPasswordState.errorMessage != null) {
          UIUtils.showMessage(
            state.forgetPasswordState.errorMessage!,
            backGroundColor: AppColors.darkRed,
            textColor: AppColors.white,
          );
        }
      },
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        bloc: cubit,
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomEditTextWidget(
                  edtTxtController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isEnabled: !state.forgetPasswordState.isLoading,
                  labelText: AppTextConstants.emailLabel,
                  hintText: AppTextConstants.emailHint,
                  focusErrorText: ValidationConstants.invalidEmail,
                  validator: _validateEmail,
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

  String? _validateEmail(String? value) {
    return AppValidators.validateEmail(value ?? '');
  }
}
