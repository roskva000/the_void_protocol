import 'package:flutter/material.dart';
import '../visuals/scanline_overlay.dart';

class CrtScreen extends StatelessWidget {
  final Widget child;

  const CrtScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: const Color(0xFF111111), width: 8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // 1. Content
            Padding(padding: const EdgeInsets.all(16.0), child: child),

            // 2. Scanlines
            const Positioned.fill(
              child: IgnorePointer(
                child: ScanlineOverlay(
                  opacity: 0.15,
                  duration: Duration(seconds: 4),
                ),
              ),
            ),

            // 3. CRT Vignette & Glow
            const Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        Colors.transparent,
                        Color(0x44000000), // Mid vignette
                        Color(0xFF000000), // Hard corners
                      ],
                      stops: [0.6, 0.85, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // 4. Slight Screen Curvature Shadow (Top/Bottom)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
