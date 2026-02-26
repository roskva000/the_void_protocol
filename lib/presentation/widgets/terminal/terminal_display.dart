import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/terminal_provider.dart';

class TerminalDisplay extends ConsumerStatefulWidget {
  const TerminalDisplay({super.key});

  @override
  ConsumerState<TerminalDisplay> createState() => _TerminalDisplayState();
}

class _TerminalDisplayState extends ConsumerState<TerminalDisplay> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(terminalProvider.select((s) => s.history));

    ref.listen<List<TerminalLine>>(terminalProvider.select((s) => s.history), (
      previous,
      next,
    ) {
      if (next.length > (previous?.length ?? 0)) {
        _scrollToBottom();
      }
    });

    return ListView.builder(
      controller: _scrollController,
      // Add padding for the "curved screen" effect so text isn't cut off at corners
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final line = history[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: _buildLine(line),
        );
      },
    );
  }

  Widget _buildLine(TerminalLine line) {
    // 1. Determine Style
    TextStyle style = GoogleFonts.spaceMono(fontSize: 14, height: 1.2);

    if (line.type == LineType.input) {
      return Text(
        line.text,
        style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      );
    }

    Color color;
    switch (line.type) {
      case LineType.error:
        color = Colors.redAccent;
        break;
      case LineType.success:
        color = Colors.greenAccent;
        break;
      case LineType.system:
        color = Colors.grey;
        break;
      case LineType.output:
      default:
        color = const Color(0xFF00E5FF);
        break;
    }

    final textWidget = Text(line.text, style: style.copyWith(color: color));

    // 2. Determine Animation
    // Only animate if the line is "fresh" (e.g., created in the last 2 seconds)
    final isFresh = DateTime.now().difference(line.timestamp).inSeconds < 2;

    if (!isFresh) {
      return textWidget;
    }

    Duration speed;
    if (line.type == LineType.system) {
      speed = const Duration(milliseconds: 10);
    } else {
      speed = const Duration(milliseconds: 30);
    }

    return textWidget.animate().fadeIn(duration: speed, curve: Curves.linear);
  }
}
