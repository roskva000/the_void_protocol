import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/meta_provider.dart';
import '../../widgets/story_log_widget.dart';
import '../../widgets/visuals/cyber_panel.dart';
import '../../widgets/visuals/reactor_widget.dart';

class TerminalTab extends ConsumerWidget {
  const TerminalTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This tab is purely for narrative logs and "System Messages"
    // We can also show current critical status here.
    final meta = ref.watch(metaProvider);
    final isCrashed = meta.isCrashed;

    return Stack(
      children: [
        // 1. Reactor Core Background
        const Positioned.fill(
          child: Opacity(
            opacity: 0.8,
            child: ReactorWidget(),
          ),
        ),

        // 2. Overlay Content
        Column(
          children: [
            if (isCrashed)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CyberPanel(
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
              ),

            // Spacer to push logs to bottom or just let reactor shine
            const Spacer(),

            // Log Overlay
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CyberPanel(
                height: 120, // Small window for logs
                child: const SingleChildScrollView(
                  child: StoryLogWidget(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
