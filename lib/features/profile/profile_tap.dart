import 'package:flutter/material.dart';

import 'profile_main/presentation/views/view/profile_main_view.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Scaffold(body: Center(child: Text('Profile')));
    return const ProfileMainView();
  }
}
