import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return SizedBox(
      width: _buttonWidth(AppTextConstants.viewAll, context),
      height: 15,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: Text(
          AppTextConstants.viewAll,
          style: bodyMedium?.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primary,
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }

  double _buttonWidth(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: text),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
