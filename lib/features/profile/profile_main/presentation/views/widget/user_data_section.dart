import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/gen/assets.gen.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/spacing.dart';
import '../../view_models/profile_main_cubit.dart';
import '../../view_models/profile_main_intents.dart';
import '../../view_models/profile_main_states.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    var titleLarge = Theme.of(context).textTheme.titleLarge;
    return BlocBuilder<ProfileMainCubit, ProfileMainStates>(
      builder: (context, state) {
        if (state.userData.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.userData.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.darkRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.userData.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.darkRed,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileMainCubit>().doIntent(
                        GetUserDataIntent(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final userData = state.userData.data?.user;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Profile Image
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                child: userData?.imgAvatarURL.isNotEmpty == true
                    ? ClipOval(
                        child: Image.network(
                          userData!.imgAvatarURL,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primary,
                              ),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primary,
                      ),
              ),
              const SizedBox(height: 16),

              /// User Name and Edit Profile Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData?.firstName ?? 'Guest User',
                    style: titleLarge?.copyWith(color: AppColors.textPrimary),
                  ),
                  8.horizontalSpacing,
                  InkWell(
                    onTap: () {
                      context.read<ProfileMainCubit>().doIntent(
                        EditProfileIntent(),
                      );
                    },
                    child: Assets.images.pen.image(),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// User Email
              Text(
                userData?.email ?? 'No email available',
                style: titleLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
