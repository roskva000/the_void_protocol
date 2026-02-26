import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../providers/particle_provider.dart';

class ParticleOverlay extends ConsumerStatefulWidget {
  const ParticleOverlay({super.key});

  @override
  ConsumerState<ParticleOverlay> createState() => _ParticleOverlayState();
}

class _Particle {
  Offset position;
  Offset velocity;
  Color color;
  double life; // 1.0 to 0.0
  double size;

  _Particle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.life,
    required this.size,
  });
}

class _ParticleOverlayState extends ConsumerState<ParticleOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 365), // Run forever
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addBurst(ParticleEvent event) {
    for (int i = 0; i < event.count; i++) {
      double angle = _rng.nextDouble() * 2 * pi;
      double speed = _rng.nextDouble() * 5 + 2;

      _particles.add(_Particle(
        position: event.position,
        velocity: Offset(cos(angle) * speed, sin(angle) * speed),
        color: event.color,
        life: 1.0,
        size: _rng.nextDouble() * 3 + 1,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ParticleEvent?>(particleProvider, (previous, next) {
      if (next != null && next != previous) {
        _addBurst(next);
      }
    });

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update particles
        for (int i = _particles.length - 1; i >= 0; i--) {
          var p = _particles[i];
          p.position += p.velocity;
          p.velocity *= 0.95; // Friction
          p.life -= 0.02; // Decay
          if (p.life <= 0) {
            _particles.removeAt(i);
          }
        }

        return CustomPaint(
          painter: _ParticlePainter(_particles),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final paint = Paint()
        ..color = p.color.withValues(alpha: p.life)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(p.position, p.size * p.life, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return true; // Always repaint as particles move every frame
  }
}
