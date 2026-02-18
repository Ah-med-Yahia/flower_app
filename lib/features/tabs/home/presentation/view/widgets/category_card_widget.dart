import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.label,
    required this.bgColor,
    required this.imageUrl,
  });

  final String label;
  final Color bgColor;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Image.network(
              imageUrl,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                if (frame != null) return child;
                return Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor2,
                  highlightColor: AppColors.shimmerHighlightColor2,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 40),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
