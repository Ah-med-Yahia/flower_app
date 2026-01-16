import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';

class SliderIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const SliderIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Container(
          width: 13,
          height: 13,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? AppColors.primary : AppColors.grey,
          ),
        );
      }),
    );
  }
}
