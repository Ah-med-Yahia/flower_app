import 'package:flutter/material.dart';
import 'package:flower_app/core/gen/assets.gen.dart';

class TrackOrderCarIllustration extends StatefulWidget {
  final String state;
  const TrackOrderCarIllustration({super.key, required this.state});

  @override
  State<TrackOrderCarIllustration> createState() =>
      _TrackOrderCarIllustrationState();
}

class _TrackOrderCarIllustrationState extends State<TrackOrderCarIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _floatAnimation.value),
        child: child,
      ),
      child: Assets.images.car.image(
        width: 220,
        height: 130,
        fit: BoxFit.contain,
      ),
    );
  }
}
