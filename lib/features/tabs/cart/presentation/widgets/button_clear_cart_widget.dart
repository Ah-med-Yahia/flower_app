import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonClearCartWidget extends StatelessWidget {
  const ButtonClearCartWidget({super.key, required this.onConfirm});
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      height: screenSize.height * .057,
      width: screenSize.width * .096,
      child: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ConfirmationDialog(
                onConfirm: onConfirm,
                title: AppTextConstants.clearCart,
                message: AppTextConstants.clearCartConfirmation,
                icon: Icons.delete_outline,
              );
            },
          );
        },
        padding: EdgeInsets.zero,
        icon: Column(
          children: [
            SvgPicture.asset(
              Assets.icons.clearCart.path,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            Text(
              AppTextConstants.clearCart,
              style: textStyle.labelSmall!.copyWith(
                decoration: TextDecoration.underline,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
