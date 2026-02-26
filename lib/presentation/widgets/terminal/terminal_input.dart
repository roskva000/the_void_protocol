import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/terminal_provider.dart';
import '../../providers/sound_provider.dart';
import '../../providers/haptic_provider.dart';

class TerminalInput extends ConsumerStatefulWidget {
  const TerminalInput({super.key});

  @override
  ConsumerState<TerminalInput> createState() => _TerminalInputState();
}

class _TerminalInputState extends ConsumerState<TerminalInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text;
    if (text.isEmpty) return;

    ref.read(terminalProvider.notifier).processCommand(text);
    ref.read(soundProvider).play('enter'); // Placeholder ID
    ref.read(hapticProvider).medium();

    _controller.clear();
    // Keep focus
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = ref.watch(terminalProvider.select((s) => s.isProcessing));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.black,
      child: Row(
        children: [
          Text(
            "> ",
            style: GoogleFonts.spaceMono(
              color: const Color(0xFF00E5FF),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !isProcessing,
              style: GoogleFonts.spaceMono(
                color: Colors.white,
                fontSize: 16,
              ),
              cursorColor: const Color(0xFF00E5FF),
              cursorWidth: 8, // Block cursor
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: (_) => _submit(),
              onChanged: (_) {
                 // Play typing sound on every keypress
                 ref.read(soundProvider).playTyping();
                 ref.read(hapticProvider).light();
              },
            ),
          ),
          if (isProcessing)
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: const Color(0xFF00E5FF),
              ),
            ),
        ],
      ),
    );
  }
}
