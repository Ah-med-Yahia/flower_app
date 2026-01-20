import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/custom_eleveted_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.error, this.onTryAgain});

  final String error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.red, size: 80),
            const SizedBox(height: 16),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            if (onTryAgain != null)
              SizedBox(
                width: 200, // Limit button width
                child: CustomElevatedButtonWidget(
                  onPressed: onTryAgain!,
                  text: ErrorsConstant.retryAgain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
