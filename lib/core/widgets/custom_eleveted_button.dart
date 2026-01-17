import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text ?? '',
          style: myTextTheme.titleSmall?.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
