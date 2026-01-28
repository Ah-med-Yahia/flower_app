import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes_constant.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () =>
              context.pushNamed(AppRoutesConstants.changePasswordRoute),
          child: const Text('Profile'),
        ),
      ),
    );
  }
}
