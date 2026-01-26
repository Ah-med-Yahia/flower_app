import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/validators/app_validators.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_events.dart';

class PhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final RegisterCubit cubit;

  const PhoneFieldWidget({
    super.key,
    required this.controller,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: AppTextConstants.phoneNumber,
        hintText: AppTextConstants.enterPhoneNumber,
      ),
      validator: AppValidators.validatePhoneNumber,
      onChanged: (v) => cubit.doIntent(PhoneNumberChanged(v)),
    );
  }
}
