import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/constants/app_text_constants.dart';

class CustomBtnAddCardWidget extends StatelessWidget {
  final VoidCallback? onAddToCart;

  const CustomBtnAddCardWidget({super.key, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: ElevatedButton(
          onPressed: onAddToCart,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(Icons.shopping_cart_outlined),
              Text(
                AppTextConstants.addToCart,
                style: TextTheme.of(context).titleSmall?.copyWith(
                  fontSize: 13,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColors.background,
                  letterSpacing: 0.10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
