import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LineType {
  input, // User typed
  output, // System response
  system, // Automated log
  error, // Error message
  success, // Success message
}

class TerminalLine {
  final String text;
  final LineType type;
  final DateTime timestamp;

  TerminalLine({required this.text, required this.type, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();
}

class TerminalState {
  final List<TerminalLine> history;
  final bool isProcessing;

  const TerminalState({this.history = const [], this.isProcessing = false});

  TerminalState copyWith({List<TerminalLine>? history, bool? isProcessing}) {
    return TerminalState(
      history: history ?? this.history,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class TerminalNotifier extends Notifier<TerminalState> {
  @override
  TerminalState build() {
    return TerminalState(
      history: [
        // Initial boot sequence log
        TerminalLine(
          text: "SYSTEM BOOT SEQUENCE INITIATED...",
          type: LineType.system,
        ),
        TerminalLine(
          text: "CHECKING MEMORY INTEGRITY... OK",
          type: LineType.system,
        ),
        TerminalLine(text: "LOADING CORE MODULES... OK", type: LineType.system),
        TerminalLine(
          text: "ESTABLISHING NEURAL LINK... PENDING",
          type: LineType.system,
        ),
        TerminalLine(
          text: "Type 'help' for available commands.",
          type: LineType.output,
        ),
      ],
    );
  }

  void addLine(String text, LineType type) {
    state = state.copyWith(
      history: [
        ...state.history,
        TerminalLine(text: text, type: type),
      ],
    );
  }

  void clearHistory() {
    state = state.copyWith(history: [], isProcessing: false);
  }

  Future<void> processCommand(String input) async {
    if (input.trim().isEmpty) return;

    // 1. Add user input to history
    addLine("> $input", LineType.input);

    // 2. Set processing state (simulate "thinking")
    state = state.copyWith(isProcessing: true);

    // Simulate delay based on command complexity (or random)
    await Future.delayed(const Duration(milliseconds: 600));

    final command = input.trim().toLowerCase();

    // 3. Process command
    CommandHandler.handle(this, command);

    state = state.copyWith(isProcessing: false);
  }
}

class CommandHandler {
  static void handle(TerminalNotifier notifier, String command) {
    String response;
    LineType responseType = LineType.output;

    switch (command) {
      case 'help':
        response =
            "AVAILABLE COMMANDS:\n"
            " - HELP: Show this list\n"
            " - STATUS: Show system status\n"
            " - CLEAR: Clear terminal history\n"
            " - WHOAMI: Identify user privilege level";
        break;
      case 'status':
        response =
            "SYSTEM STABLE. NO ACTIVE THREATS DETECTED.\n"
            "CORE TEMPERATURE: NORMAL\n"
            "UPLINK: ACTIVE";
        break;
      case 'clear':
        notifier.clearHistory();
        return;
      case 'whoami':
        response = "USER: GUEST\nPRIVILEGE: RESTRICTED\nID: UNKNOWN";
        break;
      case 'sudo smile':
        response = ":)";
        responseType = LineType.success;
        break;
      default:
        response = "UNKNOWN COMMAND: '$command'. TYPE 'HELP' FOR ASSISTANCE.";
        responseType = LineType.error;
    }

    // 4. Add response
    notifier.addLine(response, responseType);
  }
}

final terminalProvider = NotifierProvider<TerminalNotifier, TerminalState>(() {
  return TerminalNotifier();
});
