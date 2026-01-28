import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/theme/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.background),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: AppTextConstants.search,
          prefixIcon: Icon(Icons.search, color: AppColors.iconGrey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
