import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../view_models/profile_main_cubit.dart';
import '../../view_models/profile_main_intents.dart';
import '../../view_models/profile_main_states.dart';
import 'order_and_address_section.dart';

class LanguageAndPoliciesSection extends StatelessWidget {
  const LanguageAndPoliciesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          BlocBuilder<ProfileMainCubit, ProfileMainStates>(
            builder: (context, state) {
              return ProfileCardItem(
                title: AppTextConstants.language,
                icon: Icons.translate,
                showArrow: false,
                trailingWidget: InkWell(
                  onTap: () {
                    // Proper MVI: View sends Intent to Cubit only
                    // UI events are handled by the parent ProfileMainBody widget
                    context.read<ProfileMainCubit>().doIntent(
                      SelectLanguageIntent(),
                    );
                  },
                  child: Text(
                    state.selectedLanguage ?? AppTextConstants.english,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              );
            },
          ),
          InkWell(
            onTap: () {},
            child: const ProfileCardItem(
              showIcon: false,
              title: AppTextConstants.aboutUsPolicy,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ProfileCardItem(
              showIcon: false,
              title: AppTextConstants.termsAndConditionsPolicy,
            ),
          ),
        ],
      ),
    );
  }
}
