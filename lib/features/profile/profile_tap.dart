import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileTap extends StatelessWidget {
  const ProfileTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Profile'.tr())));
  }
}
