import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_events.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_states.dart';
import 'package:flutter/material.dart';
class SignUpButtonWidget extends StatelessWidget {
  final RegisterCubit cubit;
  final GlobalKey<FormState> formKey;
  final RegisterStates state;
  final Map<String, String> values;

  const SignUpButtonWidget({
    super.key,
    required this.cubit,
    required this.formKey,
    required this.state,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isFormValid
            ? () {
                if (formKey.currentState!.validate()) {
                  cubit.doIntent(
                    SignUpButtonPressed(
                      firstName: values[AppTextConstants.firstName.tr()]!,
                      lastName: values[AppTextConstants.lastName.tr()]!,
                      email: values[AppTextConstants.email.tr()]!,
                      password: values[AppTextConstants.password.tr()]!,
                      confirmPassword: values[AppTextConstants.confirmPassword.tr()]!,
                      phoneNumber: values[AppTextConstants.phoneNumber.tr()]!,
                      gender: state.gender,
                    ),
                  );
                }
              }
            : null,
        child: Text(
          AppTextConstants.signUp.tr(),
          style: const TextStyle(color: AppColors.background),
        ),
      ),
    );
  }
}
