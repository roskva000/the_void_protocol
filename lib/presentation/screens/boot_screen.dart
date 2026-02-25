import 'package:flutter/material.dart';
import 'main_game_screen.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  final List<String> _bootLines = [];
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _startBootSequence();
  }

  Future<void> _startBootSequence() async {
    final lines = [
      "BIOS CHECK... OK",
      "MEMORY... 64TB ALLOCATED",
      "LOADING KERNEL... DONE",
      "MOUNTING VOID PROTOCOL...",
      "ESTABLISHING NEURAL LINK...",
      "...",
      "CONNECTED."
    ];

    for (var line in lines) {
      if (!mounted) return;
      await Future.delayed(
        Duration(milliseconds: 200 + (line.length * 10)),
      );
      if (mounted) {
        setState(() {
          _bootLines.add(line);
        });
      }
    }

    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _enterSystem() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainGameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _bootLines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      _bootLines[index],
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        color: Colors.greenAccent,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isFinished)
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, val, child) {
                    return Opacity(
                      opacity: val,
                      child: TextButton(
                        onPressed: _enterSystem,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "> ENTER THE VOID <",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
