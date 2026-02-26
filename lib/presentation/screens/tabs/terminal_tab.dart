import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/terminal/crt_screen.dart';
import '../../widgets/terminal/terminal_display.dart';
import '../../widgets/terminal/terminal_input.dart';
import '../../widgets/visuals/reactor_widget.dart';

class TerminalTab extends ConsumerWidget {
  const TerminalTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // 1. Background Reactor (Subtle)
        const Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: ReactorWidget(),
          ),
        ),

        // 2. Main Terminal Interface
        Column(
          children: [
            // Display Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: CrtScreen(
                  child: const TerminalDisplay(),
                ),
              ),
            ),

            // Input Area
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TerminalInput(),
            ),
          ],
        ),
      ],
    );
  }
}
