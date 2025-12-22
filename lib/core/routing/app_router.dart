import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_exam_app/core/constants/api_errors_constants.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: Text(ApiErrorsKeys.okKey.tr())),
      body: Center(child: Text(ApiErrorsKeys.defaultErrorKey.tr())),
    ),
    routes: [
      // Define your routes here
    ],
  );
}
