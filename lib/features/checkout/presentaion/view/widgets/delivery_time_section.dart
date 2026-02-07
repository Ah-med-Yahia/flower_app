import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../cubit/checkout_cubit.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CheckoutCubit>();
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppTextConstants.deliveryTime,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  AppTextConstants.schedule,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: StreamBuilder<String>(
                  stream: viewModel.currentDateStream(),
                  builder: (context, snapshot) {
                    final isLoading =
                        !snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting;
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppTextConstants.instant} ',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Skeletonizer(
                              enabled: isLoading,
                              child: Text(
                                snapshot.hasData
                                    ? '${AppTextConstants.arriveBy} ${snapshot.data!}'
                                    : '${AppTextConstants.arriveBy} --:--',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: snapshot.hasData
                                          ? AppColors.green
                                          : Colors.grey[400],
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
