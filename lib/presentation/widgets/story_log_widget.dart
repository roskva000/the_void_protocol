import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:the_void_protocol/presentation/providers/story_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';

class StoryLogWidget extends ConsumerStatefulWidget {
  const StoryLogWidget({super.key});

  @override
  ConsumerState<StoryLogWidget> createState() => _StoryLogWidgetState();
}

class _StoryLogWidgetState extends ConsumerState<StoryLogWidget> {
  Timer? _fadeTimer;
  bool _isVisible = false;
  StoryLog? _currentLog;

  @override
  void dispose() {
    _fadeTimer?.cancel();
    super.dispose();
  }

  void _showLog(StoryLog log) {
    _fadeTimer?.cancel();
    setState(() {
      _currentLog = log;
      _isVisible = true;
    });

    // Fade out after 6 seconds
    _fadeTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<List<StoryLog>>(storyProvider, (previous, next) {
      if (next.isNotEmpty && (previous == null || next.last != previous.last)) {
        _showLog(next.last);
      }
    });

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1500),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppColors.black.withValues(
          alpha: 0.5,
        ), // Slight dark backdrop just for text
        child: _currentLog == null
            ? const SizedBox.shrink()
            : AnimatedTextKit(
                key: ValueKey(
                  _currentLog!.timestamp,
                ), // Force rebuild on new log
                animatedTexts: [
                  TypewriterAnimatedText(
                    '> ${_currentLog!.message}',
                    textStyle: GoogleFonts.spaceMono(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    speed: const Duration(milliseconds: 50),
                    cursor: '_',
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
              ),
      ),
    );
  }
}
