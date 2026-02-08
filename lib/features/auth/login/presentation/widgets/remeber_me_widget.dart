import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemeberMeWidget extends StatelessWidget {
  const RemeberMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: BlocBuilder<LoginCubit, LoginStates>(
            builder: (context, state) {
              return Checkbox(
                checkColor: AppColors.background,
                activeColor: AppColors.primary,
                value: state.rememberMe,
                onChanged: (_) => loginCubit.doIntent(RememberMeToggled()),
              );
            },
          ),
        ),
        TextButton(
          child: Text(AppTextConstants.rememberMe, style: textTheme.titleSmall),
          onPressed: () {
            loginCubit.doIntent(RememberMeToggled());
          },
        ),
      ],
    );
  }
}
