import 'package:flutter/material.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class TabIndicator extends StatelessWidget {
  final bool isSelected;
  final double width;

  const TabIndicator({Key? key, required this.isSelected, required this.width})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: isSelected ? width : 0,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
