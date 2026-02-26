import 'package:flutter/material.dart';

class ScanlineOverlay extends StatefulWidget {
  final double opacity;
  final Duration duration; // Time to scroll 1 scanline cycle (e.g. 4px)

  const ScanlineOverlay({
    super.key,
    this.opacity = 0.15, // Subtle
    this.duration = const Duration(seconds: 4), // Slow crawl
  });

  @override
  State<ScanlineOverlay> createState() => _ScanlineOverlayState();
}

class _ScanlineOverlayState extends State<ScanlineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _ScanlinePainter(
              scrollProgress: _controller.value,
              opacity: widget.opacity,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  final double scrollProgress; // 0.0 to 1.0
  final double opacity;

  _ScanlinePainter({required this.scrollProgress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..strokeWidth = 1.0;

    const double scanlineHeight = 4.0;

    // Offset causes the lines to scroll down. Max value is 4.0.
    final double offset = scrollProgress * scanlineHeight;

    // Start drawing from just above the screen to ensure coverage as lines move down
    for (double y = offset - scanlineHeight; y < size.height; y += scanlineHeight) {
      if (y >= 0) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ScanlinePainter oldDelegate) {
    return oldDelegate.scrollProgress != scrollProgress ||
           oldDelegate.opacity != opacity;
  }
}
