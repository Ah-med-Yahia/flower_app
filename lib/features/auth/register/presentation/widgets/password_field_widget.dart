import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_events.dart';


class PasswordFieldsWidget extends StatelessWidget {
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final RegisterCubit cubit;

  const PasswordFieldsWidget({
    super.key,
    required this.password,
    required this.confirmPassword,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: AppTextConstants.password,
              hintText: AppTextConstants.enterPassword,
            ),
            validator: (v) => v.validatePassword,
            onChanged: (v) => cubit.doIntent(PasswordChanged(v)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: confirmPassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: AppTextConstants.confirmPassword,
            ),
            validator: (v) => v.validateMatch(password.text),
            onChanged: (v) =>
                cubit.doIntent(ConfirmPasswordChanged(v)),
          ),
        ),
      ],
    );
  }
}
