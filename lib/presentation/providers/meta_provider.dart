import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/overheat.dart';
import '../../domain/entities/tech_tree.dart';

class MetaState {
  final Overheat overheat;
  final TechTree techTree;
  final double remnantData; // Prestige currency
  final double momentum; // Global speed multiplier

  const MetaState({
    this.overheat = const Overheat(),
    this.techTree = const TechTree(),
    this.remnantData = 0.0,
    this.momentum = 1.0,
  });

  MetaState copyWith({
    Overheat? overheat,
    TechTree? techTree,
    double? remnantData,
    double? momentum,
  }) {
    return MetaState(
      overheat: overheat ?? this.overheat,
      techTree: techTree ?? this.techTree,
      remnantData: remnantData ?? this.remnantData,
      momentum: momentum ?? this.momentum,
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

  void updateOverheat(double addedOverheat) {
    double newPool = state.overheat.currentPool + addedOverheat;
    bool newThrottlingState = state.overheat.isThrottling;

    if (newPool >= state.overheat.maxTolerance) {
      newThrottlingState = true;
    }
    // Cooling logic if overheat drops to 0 could be placed here or in pipeline

    state = state.copyWith(
      overheat: state.overheat.copyWith(
        currentPool: newPool,
        isThrottling: newThrottlingState,
      ),
    );
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
    );
  }

  void unlockTech(TechTree updatedTree) {
    state = state.copyWith(techTree: updatedTree);
  }
}

final metaProvider = NotifierProvider<MetaNotifier, MetaState>(() {
  return MetaNotifier();
});
