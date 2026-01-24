import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../view_models/profile_main_cubit.dart';
import '../../view_models/profile_main_intents.dart';
import '../../view_models/profile_main_states.dart';
import 'order_and_address_section.dart';

class LanguageAndPolicesSection extends StatelessWidget {
  const LanguageAndPolicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          BlocBuilder<ProfileMainCubit, ProfileMainStates>(
            builder: (context, state) {
              return ProfileCardItem(
                title: 'Language',
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
                    state.selectedLanguage ?? 'English',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              );
            },
          ),
          const ProfileCardItem(showIcon: false, title: 'About us'),
          const ProfileCardItem(showIcon: false, title: 'Terms & conditions'),
        ],
      ),
    );
  }
}
