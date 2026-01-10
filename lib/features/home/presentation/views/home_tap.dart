import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/app_reoutes_constants.dart';
import 'package:online_exam_app/core/widgets/custom_eleveted_button.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButtonWidget(
          onPressed: () {
            context.push(
              AppReoutesConstants.productDetailsRoute,
              extra: '673e1cd711599201718280fb',
            );
          },
          text: 'Go to Product Details',
        ),
      ),
    );
  }
}
