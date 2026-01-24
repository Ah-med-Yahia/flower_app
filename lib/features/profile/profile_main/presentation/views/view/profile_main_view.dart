import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/gen/assets.gen.dart';
import '../../view_models/profile_main_cubit.dart';
import 'profile_main_body.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.logo.image(key: const Key('logo')),
        actions: [
          Assets.images.notification.image(key: const Key('notification')),
        ],
        actionsPadding: const EdgeInsets.only(right: 8),
      ),
      body: BlocProvider<ProfileMainCubit>(
        create: (context) => getIt<ProfileMainCubit>(),
        child: const ProfileMainBody(),
      ),
    );
  }
}
