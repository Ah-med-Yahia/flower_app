import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/app_routes_constant.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/shared/presentation/widgets/loading_indicator_widget.dart';
import '../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../../../../../core/shared/presentation/widgets/toast_utils.dart';
import '../../view_models/verify_otp/verify_otp_code_cubit.dart';
import '../../view_models/verify_otp/verify_otp_code_events.dart';
import '../../view_models/verify_otp/verify_otp_code_state.dart';
import '../shared_widgets/custom_elevated_button_widget.dart';
import 'custom_pin_code_input_field_widget.dart';

class VerifyOtpBody extends StatefulWidget {
  const VerifyOtpBody({super.key, required this.cubit, required this.email});

  final VerifyOtpCodeCubit cubit;
  final String email;

  @override
  State<VerifyOtpBody> createState() => _VerifyOtpBodyState();
}

class _VerifyOtpBodyState extends State<VerifyOtpBody> {
  late final TextEditingController _pinController;
  late final FocusNode _focusNode;
  String? _lastErrorMessage; // Track last error to avoid duplicate toasts

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _focusNode = FocusNode();

    // Listen to events stream for navigation and other side effects
    _listenToEvents();
  }

  void _listenToEvents() {
    // Listen to state changes for error handling
    widget.cubit.stream.listen((state) {
      if (!mounted) return;
      // if (kDebugMode) {
      //   print(
      //     '📊 State changed - isLoading: ${state.verifyOtpCodeState.isLoading},'
      //     ' error: ${state.verifyOtpCodeState.errorMessage},'
      //     ' data: ${state.verifyOtpCodeState.data}',
      //   );
      // }

      // Show toast on error only if it's a new error message
      final currentError = state.verifyOtpCodeState.errorMessage;
      if (currentError != null && currentError != _lastErrorMessage) {
        _lastErrorMessage = currentError;
        // Show toast for new error
        ToastUtils.showErrorToast(context, currentError);
      } else if (currentError == null) {
        // Clear last error when state is successful
        _lastErrorMessage = null;
      }
    });

    // Listen to events for navigation and other side effects
    widget.cubit.eventsStream.listen((event) {
      if (!mounted) return;

      // debugPrint('🎯 Event received: $event');

      switch (event) {
        case NavigateToResetPassword():
          // if (kDebugMode) print('✅ Navigating to Reset Password');
          // Navigate to reset password screen
          context.pushReplacement(
            AppRoutesConstants.resetPasswordRoute,
            extra: widget.email,
          );
          break;
        case ResendOtpCodeEvent():
          // if (kDebugMode) print('🔄 Resending OTP');
          ToastUtils.showInfoToast(context, AppTextConstants.otpResentSuccess);
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitOtp() {
    if (_pinController.text.length == 6) {
      widget.cubit.doIntent(VerifyOtpCodeEvent(otpCode: _pinController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;

    return BlocBuilder<VerifyOtpCodeCubit, VerifyOtpCodeState>(
      bloc: cubit,
      builder: (context, state) {
        // Show loading indicator when API is processing
        if (state.verifyOtpCodeState.isLoading) {
          return const Center(child: LoadingIndicator(size: 150, repeat: true));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: CustomPinCodeInputFieldWidget(
                state: state,
                pinController: _pinController,
                focusNode: _focusNode,
                onCompleted: (String value) {
                  _submitOtp();
                },
              ),
            ),
            32.verticalSpacing,
            CustomElevatedButtonWidget(onPressed: _submitOtp),
          ],
        );
      },
    );
  }
}
