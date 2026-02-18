import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/constants/app_ui_key_constant.dart';
import '../../../../../../../core/constants/errors_constants.dart';
import '../../../../../../../core/constants/validation_constants.dart';
import '../../../../../../../core/gen/assets.gen.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/shared/presentation/widgets/custom_error_widget.dart';
import '../../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../view_models/profile_main_cubit.dart';
import '../../view_models/profile_main_intents.dart';
import '../../view_models/profile_main_states.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
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
          return CustomErrorWidget(
            key: const Key(AppUiKeyConstant.profileUserInfoShowErrorWidgetKey),
            error: state.userData.errorMessage ?? ErrorsConstant.defaultError,
            onTryAgain: () =>
                context.read<ProfileMainCubit>().doIntent(GetUserDataIntent()),
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
              16.verticalSpacing,

              /// User Name and Edit Profile Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData?.firstName ?? AppTextConstants.guestUser,
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
              8.verticalSpacing,

              /// User Email
              Text(
                userData?.email ?? ValidationConstants.noEmailAvailable,
                style: titleLarge?.copyWith(color: AppColors.textSecondary),
              ),
              16.verticalSpacing,
            ],
          ),
        );
      },
    );
  }
}
