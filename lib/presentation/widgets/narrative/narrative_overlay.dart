import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/narrative_provider.dart';
import 'terminal_dialog.dart';

class NarrativeOverlay extends ConsumerWidget {
  const NarrativeOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(narrativeProvider);
    final event = state.currentEvent;

    if (event == null) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5), // dim background
        alignment: Alignment.center,
        child: TerminalDialog(
          title: 'SYSTEM MESSAGE // ${event.id.toUpperCase()}',
          message: event.message,
          isGlitched: event.isGlitched,
          onDismiss: () {
            ref.read(narrativeProvider.notifier).dismissCurrentEvent();
          },
        ),
      ),
    );
  }
}
