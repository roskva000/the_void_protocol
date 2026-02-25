import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/overheat.dart';
import '../../domain/entities/tech_tree.dart';

class MetaState {
  final Overheat overheat;
  final TechTree techTree;
  final double remnantData; // Prestige currency
  final double momentum; // Global speed multiplier
  final bool isCrashed; // If true, production is halted
  final DateTime? crashEndTime;

  const MetaState({
    this.overheat = const Overheat(),
    this.techTree = const TechTree(),
    this.remnantData = 0.0,
    this.momentum = 1.0,
    this.isCrashed = false,
    this.crashEndTime,
  });

  MetaState copyWith({
    Overheat? overheat,
    TechTree? techTree,
    double? remnantData,
    double? momentum,
    bool? isCrashed,
    DateTime? crashEndTime,
  }) {
    return MetaState(
      overheat: overheat ?? this.overheat,
      techTree: techTree ?? this.techTree,
      remnantData: remnantData ?? this.remnantData,
      momentum: momentum ?? this.momentum,
      isCrashed: isCrashed ?? this.isCrashed,
      crashEndTime: crashEndTime ?? this.crashEndTime,
    );
  }
}

class MetaNotifier extends Notifier<MetaState> {
  @override
  MetaState build() {
    return const MetaState();
  }

  void setInitialState(MetaState loadedState) {
    state = loadedState;
  }

  void updateOverheat(double addedOverheat, double dt) {
    if (state.isCrashed) {
      if (state.crashEndTime != null &&
          DateTime.now().isAfter(state.crashEndTime!)) {
        state = state.copyWith(
          isCrashed: false,
          overheat: state.overheat.copyWith(currentPool: 0),
          crashEndTime: null,
        );
      }
      return;
    }

    double newPool = state.overheat.currentPool + addedOverheat;
    // Natural cooling if no heat added this tick (simplified)
    if (addedOverheat <= 0) {
      newPool -= 5.0 * dt; // Cooling rate
    }

    if (newPool < 0) newPool = 0;

    if (newPool >= 100.0) {
      // System Crash!
      state = state.copyWith(
        isCrashed: true,
        crashEndTime: DateTime.now().add(const Duration(seconds: 30)),
        overheat: state.overheat.copyWith(currentPool: 100.0),
      );
    } else {
      state = state.copyWith(
        overheat: state.overheat.copyWith(
          currentPool: newPool,
          isThrottling: newPool > 80.0, // Throttling warning zone
        ),
      );
    }
  }

  void addMomentum(double amount) {
    state = state.copyWith(momentum: state.momentum + amount);
  }

  void decayMomentum(double dt) {
    if (state.momentum > 1.0) {
      double newMomentum = state.momentum - (0.01 * dt); // 1% decay per second
      if (newMomentum < 1.0) newMomentum = 1.0;
      state = state.copyWith(momentum: newMomentum);
    }
  }

  // Ulu Cokus triggered resetting state and rewarding Remnant Data
  void triggerPrestige(double reward) {
    state = state.copyWith(
      remnantData: state.remnantData + reward,
      overheat: const Overheat(),
      momentum: 1.0,
      isCrashed: false,
      crashEndTime: null,
    );
  }

  void unlockTech(TechTree updatedTree) {
    state = state.copyWith(techTree: updatedTree);
  }
}

final metaProvider = NotifierProvider<MetaNotifier, MetaState>(() {
  return MetaNotifier();
});
