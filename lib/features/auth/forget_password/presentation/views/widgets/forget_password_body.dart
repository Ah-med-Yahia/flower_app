import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/widgets/spacing.dart';
import '../../../../../../core/constants/app_reoutes_constants.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/validators/app_validators.dart';
import '../../view_models/events/forget_password_events.dart';
import '../../view_models/forget_password_cubit.dart';
import '../../view_models/states/forget_password_state.dart';
import 'custom_edit_text_widget.dart';
import 'custom_header_title_widget.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key, required this.cubit});

  final ForgetPasswordCubit cubit;

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;
  StreamSubscription<ForgetPasswordEvents>? _eventsSubscription;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _listenToNavigationEvents();
  }

  void _listenToNavigationEvents() {
    _eventsSubscription = widget.cubit.eventsStream.listen((event) {
      if (!mounted) return;
      if (event is NavigateToVerifyOtpCode) {
        _navigateToVerifyOtp(event.email);
      }
    });
  }

  void _navigateToVerifyOtp(String email) {
    GoRouter.of(
      context,
    ).pushReplacement(AppRoutesConstants.verifyOtpRoute, extra: email);
    debugPrint('Navigate to verify OTP with email: $email');
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      widget.cubit.doIntent(ForgetPasswordEvent(email: email));
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
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                40.verticalSpacing,
                const CustomHeaderTitleWidget(
                  headerTitle: AppTextConstants.forgetPasswordHeader,
                  subTitle: AppTextConstants.forgetPasswordTitle,
                ),
                32.verticalSpacing,
                CustomEditTextWidget(
                  edtTxtController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isEnabled: !state.forgetPasswordState.isLoading,
                  labelText: AppTextConstants.emailLabel,
                  hintText: AppTextConstants.emailHint,
                  focusErrorText: AppTextConstants.emailFocusError,
                  validator: _validateEmail,
                ),
                16.verticalSpacing,
                if (state.forgetPasswordState.errorMessage != null)
                  _buildErrorMessage(state.forgetPasswordState.errorMessage!),
                if (state.forgetPasswordState.data?.message != null)
                  _buildSuccessMessage(state.forgetPasswordState.data!.message),
                24.verticalSpacing,
                _buildSubmitButton(state),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    return AppValidators.validateEmail(value ?? '');
  }

  Widget _buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.red.shade700, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.green.shade700, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ForgetPasswordState state) {
    final isLoading = state.forgetPasswordState.isLoading;
    return ElevatedButton(
      onPressed: isLoading ? null : _handleSubmit,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(AppTextConstants.confirmBtn),
    );
  }
}
