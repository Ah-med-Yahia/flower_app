import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/tab_indicator.dart';

class OccasionTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const OccasionTab({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? AppColors.primary
                  : Theme.of(context).textTheme.titleMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          TabIndicator(
            isSelected: isSelected,
            width: _IndicatorWidth(title, context),
          ),
        ],
      ),
    );
  }

  double _IndicatorWidth(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: text),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
