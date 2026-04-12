import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/widget/notification_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_ui_key_constant.dart';
import '../../../../../../core/gen/assets.gen.dart';
import '../cubit/profile_main_cubit.dart';
import 'profile_main_body.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(AppUiKeyConstant.profileAppbarKey),
        title: Assets.images.logo.image(
          key: const Key(AppUiKeyConstant.profileAppbarTxtTitleKey),
        ),
        automaticallyImplyLeading: false,
        actions: const [NotificationIcon()],
        actionsPadding: const EdgeInsets.only(right: 8),
      ),
      body: BlocProvider<ProfileMainCubit>(
        create: (context) => getIt<ProfileMainCubit>(),
        child: const ProfileMainBody(),
      ),
    );
  }
}
