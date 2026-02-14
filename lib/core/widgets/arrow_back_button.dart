import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
