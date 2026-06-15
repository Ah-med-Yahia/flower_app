import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/action_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfoCard extends StatelessWidget {
  final String name;
  final String photoUrl;
  final String phone;

  const DriverInfoCard({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.phone,
  });

  Future<void> _launchPhone() async {
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }

  Future<void> _launchWhatsApp() async {
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final phoneNoPlus = cleaned.startsWith('+')
        ? cleaned.substring(1)
        : cleaned;
    final uri = Uri.parse('https://wa.me/$phoneNoPlus');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      try {
        final fallbackUri = Uri.parse('whatsapp://send?phone=$phoneNoPlus');
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Driver photo
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: photoUrl.isNotEmpty && photoUrl.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: photoUrl,
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Container(
                      width: 52,
                      height: 52,
                      color: AppColors.lightGrey2,
                      child: Assets.images.deliveryBoy.image(
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                      ),
                    ),
                    errorWidget: (ctx, url, err) => Assets.images.deliveryBoy
                        .image(width: 52, height: 52, fit: BoxFit.cover),
                  )
                : Assets.images.deliveryBoy.image(
                    width: 52,
                    height: 52,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppTextConstants.trackOrderDriverMessage,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ActionIconButton(icon: Icons.phone_rounded, onTap: _launchPhone),
          const SizedBox(width: 8),
          ActionIconButton(
            iconWidget: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/120px-WhatsApp.svg.png',
              width: 22,
              height: 22,
              errorBuilder: (ctx2, err2, st2) => const Icon(
                Icons.message_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            onTap: _launchWhatsApp,
          ),
        ],
      ),
    );
  }
}
