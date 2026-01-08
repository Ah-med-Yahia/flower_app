import 'package:flutter/material.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      iconTheme: IconThemeData(
        size: screenWidth * 0.07,
        color: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleSpacing: 0,
      ),

      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: screenWidth * 0.055,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),

        bodyMedium: TextStyle(
          fontSize: screenWidth * 0.035,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
