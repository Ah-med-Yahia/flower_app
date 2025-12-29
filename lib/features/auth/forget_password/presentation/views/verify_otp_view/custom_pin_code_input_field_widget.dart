import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../../core/theme/app_colors.dart';
import '../../view_models/verify_otp/verify_otp_code_state.dart';

class CustomPinCodeInputFieldWidget extends StatelessWidget {
  const CustomPinCodeInputFieldWidget({
    super.key,
    required this.state,
    required this.pinController,
    required this.focusNode,
    required this.onCompleted,
  });

  final TextEditingController pinController;
  final FocusNode focusNode;
  final void Function(String)? onCompleted;

  final VerifyOtpCodeState state;

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme;
    final PinTheme defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: myTextTheme.titleLarge,
      decoration: BoxDecoration(
        color: AppColors.textSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
    );
    final PinTheme focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(color: AppColors.primary),
    );
    final PinTheme errorPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: myTextTheme.titleLarge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Pinput(
      controller: pinController,
      focusNode: focusNode,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      errorPinTheme: errorPinTheme,
      focusedPinTheme: focusedPinTheme,
      validator: (value) {
        if (value == null || value.isEmpty) {
          final message = 'Please enter OTP code';
          return message;
        }
        if (value.length < 6) {
          final message = 'OTP must be 6 digits';
          return message;
        }
        return null;
      },
      onCompleted: (pin) {
        // Call the onCompleted callback
        onCompleted?.call(pin);
      },
      onChanged: (value) {
        // TODO: Remove this debug print statement Before deploying
        if (kDebugMode) print('Changed: $value');
      },
      forceErrorState: state.verifyOtpCodeState.errorMessage != null,
      errorText: state.verifyOtpCodeState.errorMessage,
    );
  }
}
