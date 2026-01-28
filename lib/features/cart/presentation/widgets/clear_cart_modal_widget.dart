import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ClearCartConfirmationModal extends StatefulWidget {
  const ClearCartConfirmationModal({
    super.key,
    required this.onConfirm,
  });

  final VoidCallback onConfirm;

  @override
  State<ClearCartConfirmationModal> createState() =>
      _ClearCartConfirmationModalState();
}

class _ClearCartConfirmationModalState
    extends State<ClearCartConfirmationModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late final Size _screenSize;
  late final TextTheme textStyle;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
    textStyle = Theme.of(context).textTheme;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    Navigator.of(context).pop();
    widget.onConfirm();
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🗑️ Icon
                Container(
                  width: _screenSize.width * 0.25,
                  height: _screenSize.height * 0.12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.background, AppColors.lightPrimary],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  AppTextConstants.clearCart,
                  style: textStyle.headlineMedium,
                ),

                const SizedBox(height: 12),

                Text(
                  AppTextConstants.clearCartConfirmation,
                  textAlign: TextAlign.center,
                  style: textStyle.bodyMedium,
                ),

                const SizedBox(height: 32),

                // ✅ Confirm
                SizedBox(
                  width: double.infinity,
                  height: _screenSize.height * 0.07,
                  child: ElevatedButton(
                    onPressed: _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.transparent,
                      shadowColor: AppColors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.lightPrimary],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          AppTextConstants.confirm,
                          style: textStyle.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ❌ Cancel
                SizedBox(
                  width: double.infinity,
                  height: _screenSize.height * 0.07,
                  child: OutlinedButton(
                    onPressed: _handleCancel,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.lightGrey,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppTextConstants.cancel,
                      style: textStyle.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
