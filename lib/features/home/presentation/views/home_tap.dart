import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flower_app/core/widgets/custom_eleveted_button.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButtonWidget(
          onPressed: () {
            context.push(
              AppRoutesConstants.productDetailsRoute,
              extra: '673e1cd711599201718280fb',
            );
          },
          text: 'Go to Product Details',
        ),
      ),
    );
  }
}
