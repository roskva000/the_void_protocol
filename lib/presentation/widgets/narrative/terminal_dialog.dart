import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/void_theme.dart';
import '../visuals/glitch_effect.dart';

class TerminalDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onDismiss;
  final bool isGlitched;

  const TerminalDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onDismiss,
    this.isGlitched = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: GlitchEffect(
          isGlitched: isGlitched,
          intensity: 0.3,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: VoidTheme.voidBlack,
              border: Border.all(color: VoidTheme.neonCyan, width: 2),
              boxShadow: [
                BoxShadow(
                  color: VoidTheme.neonCyan.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  color: VoidTheme.neonCyan.withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.shareTechMono(
                          color: VoidTheme.neonCyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.terminal, color: VoidTheme.neonCyan, size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextStyle(
                    style: GoogleFonts.shareTechMono(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          message,
                          speed: const Duration(milliseconds: 30),
                          cursor: '_',
                        ),
                      ],
                      isRepeatingAnimation: false,
                      onFinished: () {
                        // Maybe auto dismiss or show button?
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Footer / Button
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onDismiss,
                      style: TextButton.styleFrom(
                        foregroundColor: VoidTheme.voidBlack,
                        backgroundColor: VoidTheme.neonCyan,
                        shape: const BeveledRectangleBorder(),
                      ),
                      child: Text(
                        'ACKNOWLEDGE',
                        style: GoogleFonts.shareTechMono(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
