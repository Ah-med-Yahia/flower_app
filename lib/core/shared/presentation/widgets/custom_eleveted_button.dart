import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
    this.backgroundColor,
    this.textColor,
  });

  final VoidCallback onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        onPressed: onPressed,
        style: backgroundColor != null || textColor != null
            ? ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
              )
            : null,
        child: Text(text ?? ''),
      ),
    );
  }
}
