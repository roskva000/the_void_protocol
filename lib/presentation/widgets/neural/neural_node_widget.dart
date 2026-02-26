import 'package:flutter/material.dart';
import '../../theme/void_theme.dart';

enum NodeStatus {
  locked,
  available,
  purchased,
}

class NeuralNodeWidget extends StatefulWidget {
  final String id;
  final String label;
  final String? subLabel;
  final NodeStatus status;
  final VoidCallback onTap;
  final double size;

  const NeuralNodeWidget({
    super.key,
    required this.id,
    required this.label,
    this.subLabel,
    required this.status,
    required this.onTap,
    this.size = 60,
  });

  @override
  State<NeuralNodeWidget> createState() => _NeuralNodeWidgetState();
}

class _NeuralNodeWidgetState extends State<NeuralNodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = _getColorForStatus(widget.status);
    final bool isActive = widget.status == NodeStatus.available;

    return GestureDetector(
      onTap: widget.status == NodeStatus.locked ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = isActive ? _pulseAnimation.value : 1.0;

          return Transform.scale(
            scale: scale,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VoidTheme.voidBlack,
                border: Border.all(
                  color: baseColor.withValues(alpha: isActive ? 1.0 : 0.6),
                  width: isActive ? 3 : 2,
                ),
                boxShadow: [
                  if (widget.status != NodeStatus.locked)
                    BoxShadow(
                      color: baseColor.withValues(alpha: isActive ? 0.6 : 0.3),
                      blurRadius: isActive ? 15 : 8,
                      spreadRadius: isActive ? 2 : 0,
                    ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.status == NodeStatus.locked)
                      Icon(Icons.lock, color: baseColor, size: widget.size * 0.4)
                    else ...[
                      // Icon or Short Label
                      Icon(Icons.memory, color: baseColor, size: widget.size * 0.4),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorForStatus(NodeStatus status) {
    switch (status) {
      case NodeStatus.locked:
        return Colors.grey.withValues(alpha: 0.3);
      case NodeStatus.available:
        return VoidTheme.neonCyan;
      case NodeStatus.purchased:
        return VoidTheme.signalGreen;
    }
  }
}
