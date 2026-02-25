import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoryLog {
  final String message;
  final DateTime timestamp;

  const StoryLog(this.message, this.timestamp);
}

class StoryNotifier extends Notifier<List<StoryLog>> {
  @override
  List<StoryLog> build() {
    return [];
  }

  void addLog(String message) {
    // We add to the beginning so newest is first, or end depending on UI needs.
    // Assuming a terminal that prints at the bottom, we append to the end.
    state = [...state, StoryLog(message, DateTime.now())];
  }

  void clearLogs() {
    state = [];
  }
}

final storyProvider = NotifierProvider<StoryNotifier, List<StoryLog>>(() {
  return StoryNotifier();
});
