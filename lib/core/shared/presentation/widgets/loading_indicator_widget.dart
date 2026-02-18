import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool repeat;
  final BoxFit fit;
  final Color? backgroundColor;

  const LoadingIndicator({
    super.key,
    this.size = 150,
    this.repeat = true,
    this.fit = BoxFit.contain,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Lottie.asset(
        Assets.lottie.flowerLoading.path,
        width: size,
        height: size,
        fit: fit,
        repeat: repeat,
      ),
    );
  }
}
