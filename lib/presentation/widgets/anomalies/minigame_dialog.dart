import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/void_theme.dart';

class SymbolMatchMinigame extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const SymbolMatchMinigame({
    super.key,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<SymbolMatchMinigame> createState() => _SymbolMatchMinigameState();
}

class _SymbolMatchMinigameState extends State<SymbolMatchMinigame> {
  final Random _rng = Random();
  late String _targetSymbol;
  late List<String> _options;
  int _stage = 0;
  final int _maxStages = 3;

  @override
  void initState() {
    super.initState();
    _startStage();
  }

  void _startStage() {
    if (_stage >= _maxStages) {
      widget.onSuccess();
      return;
    }

    _generatePuzzle();
    // Reset timer logic would go here if using a timer per stage
    setState(() {});
  }

  void _generatePuzzle() {
    final symbols = ['0x4F', '0xA1', '0xFF', '0x00', '0x1B', '0xE9', '0x7C', '0x33'];
    _targetSymbol = symbols[_rng.nextInt(symbols.length)];

    // Generate options including target
    final Set<String> optionsSet = {_targetSymbol};
    while (optionsSet.length < 4) {
      optionsSet.add(symbols[_rng.nextInt(symbols.length)]);
    }
    _options = optionsSet.toList()..shuffle();
  }

  void _handleSelection(String selection) {
    if (selection == _targetSymbol) {
      _stage++;
      _startStage();
    } else {
      // Wrong choice
      widget.onFailure();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "BREACH DETECTED",
              style: GoogleFonts.spaceMono(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "STAGE ${_stage + 1}/$_maxStages",
              style: GoogleFonts.spaceMono(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              "MATCH TARGET:",
              style: GoogleFonts.spaceMono(color: VoidTheme.neonCyan, fontSize: 12),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: VoidTheme.neonCyan),
                color: VoidTheme.neonCyan.withValues(alpha: 0.1),
              ),
              child: Text(
                _targetSymbol,
                style: GoogleFonts.spaceMono(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: VoidTheme.neonCyan,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.5,
              children: _options.map((option) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.grey),
                  ),
                  onPressed: () => _handleSelection(option),
                  child: Text(
                    option,
                    style: GoogleFonts.spaceMono(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
