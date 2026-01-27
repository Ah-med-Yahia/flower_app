import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
