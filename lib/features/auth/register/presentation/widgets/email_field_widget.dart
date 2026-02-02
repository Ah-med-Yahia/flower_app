import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/validators/app_validators.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_events.dart';

class EmailFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final RegisterCubit cubit;

  const EmailFieldWidget({
    super.key,
    required this.controller,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: AppTextConstants.email,
        hintText: AppTextConstants.enterEmail,
      ),
      validator: (v) => v.validateEmail,
      onChanged: (v) => cubit.doIntent(EmailChanged(v)),
    );
  }
}
