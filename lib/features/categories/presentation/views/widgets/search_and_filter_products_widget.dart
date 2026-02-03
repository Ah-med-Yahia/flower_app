import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilterProducts extends StatelessWidget {
  const SearchAndFilterProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: TextField(
              cursorColor: AppColors.grey,
              decoration: InputDecoration(
                hint: Row(
                  children: [
                    const Icon(Icons.search, size: 24, color: AppColors.grey),
                    4.horizontalSpacing,
                    Text(
                      AppTextConstants.search,
                      style: textTheme.titleMedium!.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AppColors.grey, width: 2),
                ),
              ),
            ),
          ),
          8.horizontalSpacing,
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.grey),
              ),
              child: SvgPicture.asset(
                Assets.icons.filterIcon.path,
                colorFilter: const ColorFilter.mode(
                  AppColors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
