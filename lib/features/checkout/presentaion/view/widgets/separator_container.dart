import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SeparatorContainer extends StatelessWidget {
  const SeparatorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      color: AppColors.whiteGray,
    );
  }
}
