import 'package:flutter/material.dart';
import 'package:online_exam_app/core/constants/app_text_constants.dart';
import 'package:online_exam_app/core/validators/app_validators.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_events.dart';

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
