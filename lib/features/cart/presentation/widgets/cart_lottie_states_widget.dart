import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartLottieStatesWidget extends StatelessWidget {
  const CartLottieStatesWidget({
    super.key,
    required this.lottie,
    required this.text,
    this.textColor,
  });
  final String lottie;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottie,
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.4,
            fit: BoxFit.contain,
            repeat: true,
          ),
          Text(
            text,
            style: textStyle.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor ?? AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
