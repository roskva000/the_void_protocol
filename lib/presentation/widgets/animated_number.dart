import 'package:flutter/material.dart';

class AnimatedNumber extends StatelessWidget {
  final double value;
  final TextStyle style;
  final int fractionDigits;

  const AnimatedNumber({
    super.key,
    required this.value,
    this.style = const TextStyle(),
    this.fractionDigits = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: value, end: value),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      builder: (context, animatedValue, child) {
        return Text(
          animatedValue.toStringAsFixed(fractionDigits),
          style: style,
        );
      },
    );
  }
}
