import 'package:flutter/material.dart';

class CyberPanel extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final bool isAlert; // If true, use red/warning border

  const CyberPanel({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding = const EdgeInsets.all(16),
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F12).withValues(alpha: 0.8),
        border: Border.all(
          color: isAlert ? const Color(0xFFFF2A2A) : const Color(0x33FFFFFF),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isAlert
                ? const Color(0xFFFF2A2A).withValues(alpha: 0.2)
                : const Color(0xFF00E5FF).withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(4), // Slightly rounded industrial
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: child,
      ),
    );
  }
}
