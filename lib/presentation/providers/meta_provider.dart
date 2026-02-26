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
  final double stability; // 0.0 to 1.0 (1.0 is stable)
  final double speedBonus; // Permanent multiplier from Prestige
  final double noiseReduction; // Permanent reduction from Prestige

  const MetaState({
    this.overheat = const Overheat(),
    this.techTree = const TechTree(),
    this.remnantData = 0.0,
    this.momentum = 1.0,
    this.isCrashed = false,
    this.crashEndTime,
    this.stability = 1.0,
    this.speedBonus = 0.0,
    this.noiseReduction = 0.0,
  });

  MetaState copyWith({
    Overheat? overheat,
    TechTree? techTree,
    double? remnantData,
    double? momentum,
    bool? isCrashed,
    DateTime? crashEndTime,
    double? stability,
    double? speedBonus,
    double? noiseReduction,
  }) {
    return MetaState(
      overheat: overheat ?? this.overheat,
      techTree: techTree ?? this.techTree,
      remnantData: remnantData ?? this.remnantData,
      momentum: momentum ?? this.momentum,
      isCrashed: isCrashed ?? this.isCrashed,
      crashEndTime: crashEndTime ?? this.crashEndTime,
      stability: stability ?? this.stability,
      speedBonus: speedBonus ?? this.speedBonus,
      noiseReduction: noiseReduction ?? this.noiseReduction,
    );
  }
}

enum PrestigeChoice { aggressive, silent }

class MetaNotifier extends Notifier<MetaState> {
  @override
  MetaState build() {
    return const MetaState();
  }

  void setInitialState(MetaState loadedState) {
    state = loadedState;
  }

  // Main tick function for Meta Systems (Heat, Stability, Momentum)
  void tick(double dt, {double addedHeat = 0.0}) {
    if (state.isCrashed) {
      if (state.crashEndTime != null &&
          DateTime.now().isAfter(state.crashEndTime!)) {
        // Reboot system
        state = state.copyWith(
          isCrashed: false,
          overheat: state.overheat.copyWith(currentPool: 0),
          crashEndTime: null,
          stability: 0.5, // Reboot at 50% stability
          momentum: 1.0,
        );
      }
      return;
    }

    // --- Heat Logic ---
    double newHeat = state.overheat.currentPool + addedHeat;
    // Natural cooling if low heat input (simplified logic for game feel)
    if (addedHeat <= 0.5) {
      newHeat -= 5.0 * dt; // Cooling rate
    }
    if (newHeat < 0) newHeat = 0;

    // --- Stability Logic ---
    double currentStability = state.stability;

    // High heat damages stability
    if (newHeat > 80.0) {
      currentStability -= (0.05 * dt); // 5% per second at high heat
    } else if (newHeat > 50.0) {
      currentStability -= (0.01 * dt); // 1% per second at medium heat
    } else {
      // Passive regeneration if cool
      currentStability += (0.02 * dt);
    }

    // Clamp stability
    if (currentStability > 1.0) currentStability = 1.0;

    // Check for Crash conditions
    bool crashTriggered = false;
    int crashDuration = 10;

    if (newHeat >= 100.0) {
      crashTriggered = true;
      crashDuration = 15; // Heat crash
      newHeat = 100.0;
    } else if (currentStability <= 0.0) {
      crashTriggered = true;
      crashDuration = 20; // Stability failure (worse)
      currentStability = 0.0;
    }

    if (crashTriggered) {
      state = state.copyWith(
        isCrashed: true,
        crashEndTime: DateTime.now().add(Duration(seconds: crashDuration)),
        overheat: state.overheat.copyWith(currentPool: newHeat),
        stability: currentStability,
        momentum: 0.0, // Complete halt
      );
      return;
    }

    // --- Momentum Logic ---
    double newMomentum = state.momentum;
    double baseMomentum = 1.0 + state.speedBonus;
    if (state.momentum > baseMomentum) {
      newMomentum -= (0.05 * dt); // 5% decay per second
      if (newMomentum < baseMomentum) newMomentum = baseMomentum;
    }

    // Apply updates
    state = state.copyWith(
      overheat: state.overheat.copyWith(
        currentPool: newHeat,
        isThrottling: newHeat > 80.0,
      ),
      stability: currentStability,
      momentum: newMomentum,
    );
  }

  void addMomentum(double amount) {
    if (!state.isCrashed) {
      state = state.copyWith(momentum: state.momentum + amount);
    }
  }

  void restoreStability(double amount) {
    if (!state.isCrashed) {
      double newStability = state.stability + amount;
      if (newStability > 1.0) newStability = 1.0;
      state = state.copyWith(stability: newStability);
    }
  }

  // Explicit crash trigger for external events
  void triggerCrash({int duration = 10}) {
    state = state.copyWith(
      isCrashed: true,
      crashEndTime: DateTime.now().add(Duration(seconds: duration)),
      momentum: 0.0,
    );
  }

  // Ulu Cokus triggered resetting state and rewarding Remnant Data
  void triggerPrestige(double reward, PrestigeChoice choice) {
    double newSpeed = state.speedBonus;
    double newNoise = state.noiseReduction;

    if (choice == PrestigeChoice.aggressive) newSpeed += 0.1; // +10% Speed
    if (choice == PrestigeChoice.silent) newNoise += 0.1;     // -10% Noise

    state = state.copyWith(
      remnantData: state.remnantData + reward,
      overheat: const Overheat(),
      momentum: 1.0 + newSpeed, // Start with bonus
      isCrashed: false,
      crashEndTime: null,
      stability: 1.0,
      techTree: const TechTree(),
      speedBonus: newSpeed,
      noiseReduction: newNoise,
    );
  }

  // Helper to update tech tree
  void updateTechTree(TechTree Function(TechTree) update) {
    state = state.copyWith(techTree: update(state.techTree));
  }
}

final metaProvider = NotifierProvider<MetaNotifier, MetaState>(() {
  return MetaNotifier();
});
