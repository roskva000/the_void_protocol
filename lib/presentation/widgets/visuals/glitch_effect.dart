import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// A widget that applies random jitter and color overlays to simulate a glitch.
///
/// Note: This version avoids duplicating the child widget to prevent double-execution
/// of stateful logic. Instead, it uses transforms and overlay blend modes.
class GlitchEffect extends StatefulWidget {
  final Widget child;
  final bool isGlitched;
  final double intensity; // 0.0 to 1.0 (Low to High probability/severity)

  const GlitchEffect({
    super.key,
    required this.child,
    this.isGlitched = true,
    this.intensity = 0.5,
  });

  @override
  State<GlitchEffect> createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect> {
  Timer? _glitchTimer;
  double _offsetX = 0;
  double _offsetY = 0;
  Color? _overlayColor;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    if (widget.isGlitched) {
      _scheduleNextGlitch();
    }
  }

  @override
  void didUpdateWidget(GlitchEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGlitched != oldWidget.isGlitched) {
      if (widget.isGlitched) {
        _scheduleNextGlitch();
      } else {
        _stopGlitch();
      }
    }
  }

  @override
  void dispose() {
    _glitchTimer?.cancel();
    super.dispose();
  }

  void _stopGlitch() {
    _glitchTimer?.cancel();
    if (mounted) {
      setState(() {
        _offsetX = 0;
        _offsetY = 0;
        _overlayColor = null;
      });
    }
  }

  void _scheduleNextGlitch() {
    _glitchTimer?.cancel();
    if (!mounted || !widget.isGlitched) return;

    // Time between glitches: Random between 2s and 8s (reduced by intensity)
    final baseDelay = 2000;
    final variableDelay = 6000;
    final factor = (1.0 - widget.intensity).clamp(0.1, 1.0);

    final delay = Duration(
      milliseconds: baseDelay + _random.nextInt((variableDelay * factor).toInt()),
    );

    _glitchTimer = Timer(delay, _triggerGlitchBurst);
  }

  Future<void> _triggerGlitchBurst() async {
    if (!mounted) return;

    // Number of rapid shifts in this burst
    final frames = 3 + _random.nextInt(5);

    for (int i = 0; i < frames; i++) {
      if (!mounted) return;

      setState(() {
        // Jitter amount based on intensity
        final maxOffset = 4.0 * widget.intensity;
        _offsetX = (_random.nextDouble() - 0.5) * maxOffset;
        _offsetY = (_random.nextDouble() - 0.5) * maxOffset;

        // Randomly flash a color overlay
        if (_random.nextDouble() < 0.3 * widget.intensity) {
          final colors = [
            Colors.red.withValues(alpha: 0.1),
            Colors.cyan.withValues(alpha: 0.1),
            Colors.green.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ];
          _overlayColor = colors[_random.nextInt(colors.length)];
        } else {
          _overlayColor = null;
        }
      });

      // Frame duration (short for twitchy look)
      await Future.delayed(Duration(milliseconds: 30 + _random.nextInt(50)));
    }

    // Reset to normal
    if (mounted) {
      setState(() {
        _offsetX = 0;
        _offsetY = 0;
        _overlayColor = null;
      });
      _scheduleNextGlitch();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isGlitched) return widget.child;

    return Transform.translate(
      offset: Offset(_offsetX, _offsetY),
      child: Stack(
        children: [
          widget.child,
          if (_overlayColor != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: _overlayColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
