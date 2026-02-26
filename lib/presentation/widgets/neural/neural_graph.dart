import 'package:flutter/material.dart';
import '../../theme/void_theme.dart';

enum NodeStatus { locked, available, purchased }

class NeuralNodeData {
  final String id;
  final String label;
  final String? subLabel;
  final Offset position;
  final List<String> children; // Connects to these IDs (outgoing)
  final NodeStatus status;
  final VoidCallback? onTap;
  final double size;

  const NeuralNodeData({
    required this.id,
    required this.label,
    this.subLabel,
    required this.position,
    this.children = const [],
    required this.status,
    this.onTap,
    this.size = 60,
  });
}

class NeuralGraph extends StatefulWidget {
  final List<NeuralNodeData> nodes;
  final double width; // Canvas width
  final double height; // Canvas height

  const NeuralGraph({
    super.key,
    required this.nodes,
    this.width = 4000,
    this.height = 4000,
  });

  @override
  State<NeuralGraph> createState() => _NeuralGraphState();
}

class _NeuralGraphState extends State<NeuralGraph> {
  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    // Center at (2000, 2000) roughly
    // We want the view to start showing the center nodes.
    // Viewport size is unknown here but let's assume standard phone ~400x800
    // Matrix: Scale(0.5) Translate(-2000 + screenW/2, -2000 + screenH/2)
    // Actually, matrix order: Translate THEN Scale. No, Matrix is pre-multiply.
    // It's usually cleaner to set identity then manipulate.
    // For now, let's start at identity but translated to center-ish.
    // 2000, 2000 is center. We want top-left of viewport to be around 1800, 1600 maybe.

    // Create initial transform
    final matrix = Matrix4.identity()
      ..translate(-1800.0, -1600.0);

    _transformationController.value = matrix;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Deep space background
      child: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(2000), // Huge margin to fly around
        minScale: 0.1,
        maxScale: 3.0,
        constrained: false, // Infinite canvas
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            children: [
              // 0. Star Field (Static background on canvas)
              Positioned.fill(
                child: CustomPaint(
                   painter: _StarFieldPainter(),
                ),
              ),

              // 1. Connections Layer
              Positioned.fill(
                child: CustomPaint(
                  painter: _ConnectionPainter(nodes: widget.nodes),
                ),
              ),

              // 2. Nodes Layer
              ...widget.nodes.map((node) {
                // Manually position based on data
                return Positioned(
                  left: node.position.dx - (node.size / 2),
                  top: node.position.dy - (node.size / 2),
                  child: GestureDetector(
                    onTap: node.onTap,
                    child: _buildNodeContent(node),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeContent(NeuralNodeData node) {
    Color color;
    Color glowColor;

    switch (node.status) {
      case NodeStatus.purchased:
        color = const Color(0xFF00E5FF); // Neon Cyan
        glowColor = const Color(0xFF00E5FF).withOpacity(0.6);
        break;
      case NodeStatus.available:
        color = Colors.white;
        glowColor = Colors.white.withOpacity(0.4);
        break;
      case NodeStatus.locked:
      default:
        color = Colors.grey.shade800;
        glowColor = Colors.transparent;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The Circle Node
        Container(
          width: node.size,
          height: node.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black, // Center black to cover lines
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: glowColor,
                blurRadius: node.status == NodeStatus.purchased ? 15 : 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: node.status == NodeStatus.locked
                ? Icon(Icons.lock, size: node.size * 0.4, color: Colors.grey)
                : null,
          ),
        ),

        // Label
        const SizedBox(height: 4),
        Text(
          node.label,
          style: TextStyle(
            color: node.status == NodeStatus.locked
                ? Colors.grey.withOpacity(0.5)
                : const Color(0xFF00E5FF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 2),
            ],
          ),
          textAlign: TextAlign.center,
        ),
         if (node.subLabel != null)
            Text(
              node.subLabel!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
                shadows: [Shadow(color: Colors.black, blurRadius: 2)],
              ),
              textAlign: TextAlign.center,
            ),
      ],
    );
  }
}

class _ConnectionPainter extends CustomPainter {
  final List<NeuralNodeData> nodes;

  _ConnectionPainter({required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    // Map for lookup
    final nodeMap = {for (var n in nodes) n.id: n};

    for (final node in nodes) {
      for (final childId in node.children) {
        final child = nodeMap[childId];
        if (child != null) {
          final paint = Paint()
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke;

          // Simple color logic for lines
          Color startColor = Colors.grey.shade800;
          Color endColor = Colors.grey.shade800;

          if (node.status == NodeStatus.purchased) {
            startColor = const Color(0xFF00E5FF);
            if (child.status == NodeStatus.purchased) {
              endColor = const Color(0xFF00E5FF);
            } else if (child.status == NodeStatus.available) {
              endColor = Colors.white;
            }
          }

          // Draw gradient line
          // The gradient shader needs a rect spanning the line
          final rect = Rect.fromPoints(node.position, child.position);
          final gradient = LinearGradient(
            colors: [startColor, endColor],
          );

          paint.shader = gradient.createShader(rect);

          canvas.drawLine(node.position, child.position, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPainter oldDelegate) => true; // Always repaint on state change
}

class _StarFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);

    // Draw deterministic stars based on coordinates
    // Using a prime number step to scatter them
    for (double x = 0; x < size.width; x += 113) {
      for (double y = 0; y < size.height; y += 97) {
        // Pseudo-random offset using modulo
        final offsetX = (x * y) % 50;
        final offsetY = (x + y) % 40;

        // Draw small dot
        canvas.drawCircle(Offset(x + offsetX, y + offsetY), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter oldDelegate) => false;
}
