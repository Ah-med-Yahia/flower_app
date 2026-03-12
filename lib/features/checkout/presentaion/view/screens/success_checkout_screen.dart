import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessCheckOutScreen extends StatelessWidget {
  const SuccessCheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _backTohome(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTextConstants.trackOrder),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _backTohome(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(Assets.images.success.path, height: 150, width: 150),
              const SizedBox(height: 50),
              Text(
                AppTextConstants.yourOrderPlacedSuccessfully,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // context.pushNamed(AppRoutesConstants.trackOrderRoute);
                    },
                    child: Text(AppTextConstants.trackOrder),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _backTohome(BuildContext context) {
    context.goNamed(AppRoutesConstants.homeRoute);
  }
}
