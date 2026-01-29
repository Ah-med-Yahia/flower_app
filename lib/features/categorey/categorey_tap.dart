import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CategoriesTap extends StatelessWidget {
  const CategoriesTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Categories'.tr())));
  }
}
