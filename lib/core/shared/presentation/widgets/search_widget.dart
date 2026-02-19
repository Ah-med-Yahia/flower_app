import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.isSearching,
    required this.onPressedClearIcon,
    this.onTapOutside,
    required this.onTap,
    required this.onChanged,
    this.height,
  });

  final bool isSearching;
  final VoidCallback onPressedClearIcon;
  final VoidCallback? onTapOutside;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final double? height;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: controller,
        cursorColor: AppColors.grey,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: AppTextConstants.search,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          hintStyle: textTheme.titleMedium!.copyWith(color: AppColors.grey),
          prefixIcon: const Icon(Icons.search, size: 24, color: AppColors.grey),
          suffixIcon: widget.isSearching
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.grey),
                  onPressed: () {
                    widget.onPressedClearIcon();
                    controller.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.grey, width: 2),
          ),
        ),
        onTapUpOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.onTapOutside?.call();
        },
        onTap: widget.onTap,
        onChanged: widget.onChanged,
      ),
    );
  }
}
