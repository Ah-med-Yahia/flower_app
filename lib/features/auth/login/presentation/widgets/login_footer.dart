import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppTextConstants.dontHaveAccount),
        TextButton(
          onPressed: () {
            // Navigate to Sign Up screen
            context.pushNamed(AppRoutesConstants.registerRoute);
          },
          child: Text(
            AppTextConstants.signUp,
            style: textTheme.bodySmall!.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
