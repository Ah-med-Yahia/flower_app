import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TabIndicator extends StatelessWidget {
  final bool isSelected;
  final double width;

  const TabIndicator({
    super.key,
    required this.isSelected,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: width,
      height: 3,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.grey,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
