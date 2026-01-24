import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/features/edit_profile/presentation/view/screens/edit_profile_view_body_screen.dart';
import 'package:flutter/material.dart' as badges;
import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_constants.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          AppTextConstants.editProfile,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
        ),
        actions: [
          badges.Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: badges.Badge(
              label: Text("3"),
              child: Assets.svgs.notification.svg(),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: EditProfileViewBodyScreen(),
    );
  }
}
