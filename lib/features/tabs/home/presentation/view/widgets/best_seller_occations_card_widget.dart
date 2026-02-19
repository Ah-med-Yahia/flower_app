import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BestSellerOccationsCardWidget extends StatelessWidget {
  const BestSellerOccationsCardWidget({
    super.key,
    required this.image,
    required this.title,
    this.price,
  });
  final String image;
  final String title;
  final String? price;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenSize.height * 0.2,
          width: screenSize.width * 0.35,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Image.network(
            image,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              if (frame != null) return child;
              return Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  width: double.infinity,
                  height: screenSize.height * 0.2,
                  color: AppColors.white,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 40),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width * 0.35,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: bodyMedium?.copyWith(
                  fontWeight: price != null ? FontWeight.w500 : FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            if (price != null)
              Text(
                '$price ${AppTextConstants.egp}',
                style: bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
