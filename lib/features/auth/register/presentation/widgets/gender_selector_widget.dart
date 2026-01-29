import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_events.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectorWidget extends StatelessWidget {
  final RegisterCubit cubit;

  const GenderSelectorWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (_, state) {
        return Row(
          children: [
            Text(AppTextConstants.gender.tr()),
            const SizedBox(width: 20),
            Radio<String>(
              value: AppTextConstants.female,
              groupValue: state.gender,
              onChanged: (v) {
                if (v != null) cubit.doIntent(GenderChanged(v));
              },
            ),
            Text(AppTextConstants.female.tr()),
            Radio<String>(
              value: AppTextConstants.male,
              groupValue: state.gender,
              onChanged: (v) {
                if (v != null) cubit.doIntent(GenderChanged(v));
              },
            ),
            Text(AppTextConstants.male.tr()),
          ],
        );
      },
    );
  }
}
