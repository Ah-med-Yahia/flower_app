import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          width: 130,
          child: Image.network(image, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
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
