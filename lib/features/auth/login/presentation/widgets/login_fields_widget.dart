import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:flutter/material.dart';

class LoginFieldsWidget extends StatelessWidget {
  const LoginFieldsWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loginCubit,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          validator: AppValidators.validateEmail,
          onChanged: (value) {
            loginCubit.doIntent(ValidateFields(value, passwordController.text));
          },
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppTextConstants.email,
            hintText: AppTextConstants.enterEmail,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 18.0,
            ),
          ),
        ),
        24.verticalSpacing,
        TextFormField(
          controller: passwordController,
          validator: AppValidators.validateLoginPassword,
          keyboardType: TextInputType.text,
          onChanged: (value) =>
              loginCubit.doIntent(ValidateFields(emailController.text, value)),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: AppTextConstants.password,
            hintText: AppTextConstants.enterPassword,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}
