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
                      firstName: values[AppTextConstants.firstName]!,
                      lastName: values[AppTextConstants.lastName]!,
                      email: values[AppTextConstants.email]!,
                      password: values[AppTextConstants.password]!,
                      confirmPassword: values[AppTextConstants.confirmPassword]!,
                      phoneNumber: values[AppTextConstants.phoneNumber]!,
                      gender: state.gender,
                    ),
                  );
                }
              }
            : null,
        child: const Text(
          AppTextConstants.signUp,
          style: TextStyle(color: AppColors.background),
        ),
      ),
    );
  }
}
