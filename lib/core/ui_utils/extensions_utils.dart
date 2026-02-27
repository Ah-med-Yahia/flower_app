import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AuthDialogs on BuildContext {
  Future<void> showMustLoginDialog() {
    return showDialog(
      context: this,
      builder: (_) => ConfirmationDialog(
        message: AppTextConstants.mustLogin,
        icon: Icons.warning,
        title: AppTextConstants.attention,
        onConfirm: () => pushNamed(AppRoutesConstants.loginRoute),
      ),
    );
  }
}
