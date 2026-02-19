import 'package:flower_app/core/shared/presentation/widgets/tab_indicator_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OccasionTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const OccasionTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

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
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
          const SizedBox(height: 4),
          TabIndicator(
            isSelected: isSelected,
            width: _indicatorWidth(title, context),
          ),
        ],
      ),
    );
  }

  double _indicatorWidth(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: text),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
