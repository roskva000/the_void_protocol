import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../providers/meta_provider.dart';
import '../../providers/pipeline_provider.dart';
import '../../theme/void_theme.dart';

class ReactorWidget extends ConsumerStatefulWidget {
  const ReactorWidget({super.key});

  @override
  ConsumerState<ReactorWidget> createState() => _ReactorWidgetState();
}

class _ReactorWidgetState extends ConsumerState<ReactorWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meta = ref.watch(metaProvider);
    final pipeline = ref.watch(pipelineProvider);

    final double heat = meta.overheat.currentPool; // 0-100
    final double stability = meta.stability; // 0-1
    final double noise = pipeline.noise.currentAmount;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ReactorPainter(
            animationValue: _controller.value,
            heat: heat,
            stability: stability,
            noise: noise,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _ReactorPainter extends CustomPainter {
  final double animationValue;
  final double heat;
  final double stability;
  final double noise;

  _ReactorPainter({
    required this.animationValue,
    required this.heat,
    required this.stability,
    required this.noise,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) * 0.4;

    // Base Color shifts from Blue (Cool) to Red (Hot)
    final Color coreColor = Color.lerp(
      VoidTheme.neonCyan,
      VoidTheme.errorRed,
      (heat / 100).clamp(0.0, 1.0)
    )!;

    final Paint glowPaint = Paint()
      ..color = coreColor.withValues(alpha: 0.3 + (0.2 * sin(animationValue * 2 * pi)))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final Paint corePaint = Paint()
      ..color = coreColor
      ..style = PaintingStyle.fill;

    // Draw Core
    double corePulse = sin(animationValue * 4 * pi) * 5;
    if (heat > 80) corePulse *= 3; // Beat faster/harder

    // Noise jitter
    double jitterX = 0;
    double jitterY = 0;
    if (stability < 0.5) {
      final rng = Random();
      jitterX = (rng.nextDouble() - 0.5) * (1.0 - stability) * 20;
      jitterY = (rng.nextDouble() - 0.5) * (1.0 - stability) * 20;
    }

    canvas.drawCircle(center + Offset(jitterX, jitterY), (maxRadius * 0.2) + corePulse, corePaint);
    canvas.drawCircle(center + Offset(jitterX, jitterY), (maxRadius * 0.25) + corePulse, glowPaint);

    // Draw Rings
    final Paint ringPaint = Paint()
      ..color = coreColor.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 1; i <= 3; i++) {
      double radius = maxRadius * (0.3 + (i * 0.2));
      double rotation = animationValue * 2 * pi * (i % 2 == 0 ? 1 : -1) * (1 + (heat / 50));

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotation);

      // Draw dashed ring
      _drawDashedCircle(canvas, Offset.zero, radius, ringPaint, 12 + i * 4);

      canvas.restore();
    }

    // Draw "Instability" arcs if unstable
    if (stability < 0.8) {
       final Paint hazardPaint = Paint()
        ..color = VoidTheme.warningOrange.withValues(alpha: (1.0 - stability))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;

       canvas.drawArc(
         Rect.fromCircle(center: center, radius: maxRadius * 0.9),
         animationValue * pi,
         pi / 4,
         false,
         hazardPaint
       );
       canvas.drawArc(
         Rect.fromCircle(center: center, radius: maxRadius * 0.9),
         animationValue * pi + pi,
         pi / 4,
         false,
         hazardPaint
       );
    }
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius, Paint paint, int dashes) {
    double step = (2 * pi) / dashes;
    for (int i = 0; i < dashes; i++) {
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          step * i,
          step * 0.7,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ReactorPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.heat != heat ||
           oldDelegate.stability != stability;
  }
}
