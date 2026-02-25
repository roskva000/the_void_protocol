import 'dart:math';
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final bool isCorrupted;

  const GlitchText(
    this.text, {
    super.key,
    this.style,
    this.isCorrupted = false,
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final String _chars = "!@#\$%^&*()_+-=[]{}|;':,./<>?";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    if (widget.isCorrupted) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(GlitchText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCorrupted != oldWidget.isCorrupted) {
      if (widget.isCorrupted) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _corruptString(String input) {
    if (!_controller.isAnimating) return input;
    List<String> chars = input.split('');
    for (int i = 0; i < chars.length; i++) {
      if (_random.nextDouble() < 0.1) {
        chars[i] = _chars[_random.nextInt(_chars.length)];
      }
    }
    return chars.join('');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          widget.isCorrupted ? _corruptString(widget.text) : widget.text,
          style: widget.style,
        );
      },
    );
  }
}
