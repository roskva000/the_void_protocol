import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GlassPanel extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const GlassPanel({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // Crucial for BackdropFilter performance
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.glassWhite,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: AppColors.glassBorder, width: 1.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
