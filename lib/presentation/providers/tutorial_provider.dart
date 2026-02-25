import 'package:flutter_riverpod/flutter_riverpod.dart';

class TutorialState {
  final bool hasSeenManual;
  final bool hasSeenGenerator;
  final bool hasSeenOverheat;

  const TutorialState({
    this.hasSeenManual = false,
    this.hasSeenGenerator = false,
    this.hasSeenOverheat = false,
  });

  TutorialState copyWith({
    bool? hasSeenManual,
    bool? hasSeenGenerator,
    bool? hasSeenOverheat,
  }) {
    return TutorialState(
      hasSeenManual: hasSeenManual ?? this.hasSeenManual,
      hasSeenGenerator: hasSeenGenerator ?? this.hasSeenGenerator,
      hasSeenOverheat: hasSeenOverheat ?? this.hasSeenOverheat,
    );
  }
}

class TutorialNotifier extends Notifier<TutorialState> {
  @override
  TutorialState build() {
    return const TutorialState();
  }

  void markManualSeen() {
    state = state.copyWith(hasSeenManual: true);
  }

  void markGeneratorSeen() {
    state = state.copyWith(hasSeenGenerator: true);
  }

  void markOverheatSeen() {
    state = state.copyWith(hasSeenOverheat: true);
  }
}

final tutorialProvider = NotifierProvider<TutorialNotifier, TutorialState>(() {
  return TutorialNotifier();
});
