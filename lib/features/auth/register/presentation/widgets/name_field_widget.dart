import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/validators/app_validators.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_events.dart';

class NameFieldsWidget extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final RegisterCubit cubit;

  const NameFieldsWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: firstName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: AppTextConstants.firstName,
              hintText: AppTextConstants.enterFirstName,
            ),
            validator: AppValidators.validateRequired,
            onChanged: (v) => cubit.doIntent(FirstNameChanged(v)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: lastName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: AppTextConstants.lastName,
              hintText: AppTextConstants.enterLastName,
            ),
            validator: AppValidators.validateRequired,
            onChanged: (v) => cubit.doIntent(LastNameChanged(v)),
          ),
        ),
      ],
    );
  }
}
