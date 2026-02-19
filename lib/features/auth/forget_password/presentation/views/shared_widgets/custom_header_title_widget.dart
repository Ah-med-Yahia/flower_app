import 'package:flutter/material.dart';

import '../../../../../../core/shared/presentation/widgets/spacing.dart';

class CustomHeaderTitleWidget extends StatelessWidget {
  const CustomHeaderTitleWidget({
    super.key,
    required this.headerTitle,
    required this.subTitle,
  });

  final String headerTitle;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          headerTitle,
          style: myTextTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        16.verticalSpacing,
        Text(
          subTitle,
          style: myTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
