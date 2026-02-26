import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../providers/shake_provider.dart';

class ShakeWidget extends ConsumerStatefulWidget {
  final Widget child;

  const ShakeWidget({super.key, required this.child});

  @override
  ConsumerState<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends ConsumerState<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ShakeEvent? _lastEvent;
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerShake(ShakeEvent event) {
    _lastEvent = event;
    _controller.duration = event.duration;
    _controller.forward(from: 0.0);

    // Haptic Feedback based on intensity
    if (event.intensity >= 20.0) {
      HapticFeedback.heavyImpact();
    } else if (event.intensity >= 10.0) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ShakeEvent?>(shakeProvider, (previous, next) {
      if (next != null && next != previous) {
        _triggerShake(next);
      }
    });

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (!_controller.isAnimating) return widget.child;

        final double progress = _controller.value;
        final double remainingIntensity = (_lastEvent?.intensity ?? 0.0) * (1.0 - progress);

        final double dx = (_rng.nextDouble() - 0.5) * remainingIntensity * 2;
        final double dy = (_rng.nextDouble() - 0.5) * remainingIntensity * 2;

        return Transform.translate(
          offset: Offset(dx, dy),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
