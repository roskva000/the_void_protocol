import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/meta_provider.dart';
import '../../widgets/story_log_widget.dart';
import '../../widgets/visuals/cyber_panel.dart';

class TerminalTab extends ConsumerWidget {
  const TerminalTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This tab is purely for narrative logs and "System Messages"
    // We can also show current critical status here.
    final meta = ref.watch(metaProvider);
    final isCrashed = meta.isCrashed;

    return Column(
      children: [
        if (isCrashed)
          CyberPanel(
            isAlert: true,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "CRITICAL FAILURE. REBOOT IN PROGRESS...",
                    style: GoogleFonts.spaceMono(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Expanded(
          child: CyberPanel(
            child: ListView.builder(
              reverse: true, // Newest at bottom visually if we stack correctly?
              // Actually standard logs usually flow down. Let's stick to standard top-down.
              itemCount: 1, // Just the log widget for now which handles its own animation?
              // No, StoryLogWidget handles *toast* style. We want a full history here.
              // For MVP, let's reuse StoryLogWidget logic but make a proper history list.
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StoryLogWidget(), // This widget currently only shows *new* logs.
                  // TODO: Refactor StoryLogWidget to show history in this tab.
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
