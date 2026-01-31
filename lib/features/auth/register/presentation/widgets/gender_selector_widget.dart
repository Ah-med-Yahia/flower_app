import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_events.dart';
import '../cubit/register_states.dart';

class GenderSelectorWidget extends StatelessWidget {
  final RegisterCubit cubit;

  const GenderSelectorWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (_, state) {
        return Row(
          children: [
            const Text(AppTextConstants.gender),
            const SizedBox(width: 20),
            RadioGroup<String>(
              groupValue: state.gender,
              onChanged: (v) {
                if (v != null) cubit.doIntent(GenderChanged(v));
              },
              child: const Row(
                children: [
                  Radio<String>(value: AppTextConstants.female),
                  Text(AppTextConstants.female),
                  Radio<String>(value: AppTextConstants.male),
                  Text(AppTextConstants.male),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
