import 'package:flutter/material.dart';
import '../../theme/void_theme.dart';
import 'neural_node_widget.dart';

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

class NeuralGraph extends StatelessWidget {
  final List<NeuralNodeData> nodes;
  final double width; // Canvas width
  final double height; // Canvas height

  const NeuralGraph({
    super.key,
    required this.nodes,
    this.width = 2000,
    this.height = 2000,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(500), // Allow panning way out
      minScale: 0.1,
      maxScale: 2.0,
      constrained: false, // Infinite canvas
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Layer 1: Connections
            Positioned.fill(
              child: CustomPaint(
                painter: _ConnectionPainter(nodes: nodes),
              ),
            ),
            // Layer 2: Nodes
            ...nodes.map((node) {
              return Positioned(
                left: node.position.dx - (node.size / 2),
                top: node.position.dy - (node.size / 2),
                child: Column(
                  children: [
                    NeuralNodeWidget(
                      id: node.id,
                      label: node.label,
                      subLabel: node.subLabel,
                      status: node.status,
                      onTap: node.onTap ?? () {},
                      size: node.size,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      node.label,
                      style: TextStyle(
                        color: node.status == NodeStatus.locked
                            ? Colors.grey.withValues(alpha: 0.5)
                            : VoidTheme.neonCyan,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (node.subLabel != null)
                      Text(
                        node.subLabel!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ConnectionPainter extends CustomPainter {
  final List<NeuralNodeData> nodes;

  _ConnectionPainter({required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = VoidTheme.neonCyan.withValues(alpha: 0.3)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final activePaint = Paint()
      ..color = VoidTheme.signalGreen.withValues(alpha: 0.6)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // Create a map for fast lookup
    final nodeMap = {for (var node in nodes) node.id: node};

    for (final node in nodes) {
      for (final childId in node.children) {
        final childNode = nodeMap[childId];
        if (childNode != null) {
          // Determine line color:
          // If both nodes are unlocked/purchased/available, line is lit?
          // Usually, if parent is purchased, line to child is potentially active.
          final bool isActive = node.status == NodeStatus.purchased &&
                                (childNode.status == NodeStatus.available || childNode.status == NodeStatus.purchased);

          canvas.drawLine(
            node.position,
            childNode.position,
            isActive ? activePaint : paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPainter oldDelegate) {
    // If node positions or status change, repaint
    // For simplicity, just return true or check length/status
    return true;
  }
}
