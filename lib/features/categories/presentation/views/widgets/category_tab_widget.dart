import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/tab_indicator_widget.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title[0].toUpperCase() + title.substring(1),
            style: textTheme.titleMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? AppColors.primary
                  : textTheme.titleMedium?.color,
            ),
          ),
          4.verticalSpacing,
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
