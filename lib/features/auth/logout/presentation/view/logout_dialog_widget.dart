import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/custom_eleveted_button.dart';
import 'package:flutter/material.dart';

class LogoutDialogWidget extends StatelessWidget {
  final VoidCallback onLogoutConfirmed;

  const LogoutDialogWidget({super.key, required this.onLogoutConfirmed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppTextConstants.logout,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppTextConstants.confirmLogout,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () => Navigator.pop(context),
                    text: AppTextConstants.cancel,
                    textColor: AppColors.textSecondary,
                    backgroundColor: AppColors.background,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                      onLogoutConfirmed();
                    },
                    text: AppTextConstants.logout,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
