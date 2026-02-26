import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/tech_tree.dart';
import '../../domain/entities/overheat.dart';
import 'terminal_provider.dart';

enum PrestigeChoice {
  none,
  aggressive, // More remnant data, higher heat risk
  silent,     // Less remnant data, better efficiency
}

class MetaState {
  final Overheat overheat;
  final TechTree techTree;
  final double remnantData; // Prestige Currency (Void Shards)
  final double momentum;    // Production Multiplier
  final bool isCrashed;
  final double stability;   // 0.0 to 1.0

  const MetaState({
    this.overheat = const Overheat(),
    this.techTree = const TechTree(),
    this.remnantData = 0.0,
    this.momentum = 1.0,
    this.isCrashed = false,
    this.stability = 1.0,
  });

  MetaState copyWith({
    Overheat? overheat,
    TechTree? techTree,
    double? remnantData,
    double? momentum,
    bool? isCrashed,
    double? stability,
  }) {
    return MetaState(
      overheat: overheat ?? this.overheat,
      techTree: techTree ?? this.techTree,
      remnantData: remnantData ?? this.remnantData,
      momentum: momentum ?? this.momentum,
      isCrashed: isCrashed ?? this.isCrashed,
      stability: stability ?? this.stability,
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

  void updateTechTree(TechTree Function(TechTree) update) {
    state = state.copyWith(techTree: update(state.techTree));
  }

  void tick(double dt, {double addedHeat = 0.0}) {
    // 1. Calculate Heat Change
    // Base cooling - Is it affected by tech?
    double cooling = 1.0 * dt;

    // Tech modifiers
    if (state.techTree.autoPurgeUnlocked) cooling *= 1.5;
    if (state.techTree.quantumOverclockUnlocked) addedHeat *= 1.2; // Risky tech

    double newHeat = state.overheat.currentPool + addedHeat - cooling;

    // Clamp
    if (newHeat < 0) newHeat = 0;

    // Check Thresholds
    bool isThrottling = false;
    if (newHeat > state.overheat.maxPool * 0.8) {
      isThrottling = true;
    }

    // Check Crash
    bool crashed = state.isCrashed;
    double newStability = state.stability;

    if (newHeat >= state.overheat.maxPool) {
      // System Crash!
      newHeat = state.overheat.maxPool;
      if (!crashed) {
        crashed = true;
        newStability = 0.0;
        ref.read(terminalProvider.notifier).addLine("CRITICAL ERROR: SYSTEM MELTDOWN.", LineType.error);
      }
    } else {
      // Recovery
      if (crashed && newHeat < state.overheat.maxPool * 0.5) {
        crashed = false;
        ref.read(terminalProvider.notifier).addLine("SYSTEM REBOOT SUCCESSFUL.", LineType.success);
      }

      // Stability logic
      if (isThrottling) {
        newStability -= 0.05 * dt;
      } else {
        newStability += 0.05 * dt;
      }
      if (newStability < 0) newStability = 0;
      if (newStability > 1) newStability = 1;
    }

    // Handle Momentum Decay if boosted (simple logic for now)
    double newMomentum = state.momentum;
    if (newMomentum > 1.0) {
      // Decay back to 1.0 slowly
      newMomentum -= 0.1 * dt;
      if (newMomentum < 1.0) newMomentum = 1.0;
    }

    state = state.copyWith(
      overheat: state.overheat.copyWith(
        currentPool: newHeat,
        isThrottling: isThrottling,
      ),
      isCrashed: crashed,
      stability: newStability,
      momentum: newMomentum,
    );
  }

  void restoreStability(double amount) {
    double newStability = state.stability + amount;
    if (newStability < 0) newStability = 0;
    if (newStability > 1) newStability = 1;
    state = state.copyWith(stability: newStability);
  }

  void addMomentum(double amount) {
    state = state.copyWith(momentum: state.momentum + amount);
  }

  // PRESTIGE LOGIC
  void triggerPrestige(double earnedRemnants, PrestigeChoice choice) {
    // Calculate new multiplier based on choice
    double newMomentum = 1.0; // Base momentum resets usually, but prestige adds PERMANENT bonuses separately.
    // However, the previous logic added to current momentum. Let's stick to standard idle logic:
    // Prestige Currency (Remnant Data) gives a passive bonus.
    // Momentum is a temporary multiplier.

    // For now, let's say Remnant Data IS the multiplier source.
    // But to respect the code structure, we just reset state.

    double preservedMomentum = 1.0;
    if (choice == PrestigeChoice.aggressive) {
       preservedMomentum = 1.5;
    } else if (choice == PrestigeChoice.silent) {
       preservedMomentum = 1.2;
    }

    final newState = MetaState(
      overheat: const Overheat(), // Reset heat
      techTree: const TechTree(), // Reset tree
      remnantData: state.remnantData + earnedRemnants,
      momentum: preservedMomentum,
      isCrashed: false,
      stability: 1.0,
    );

    state = newState;

    ref.read(terminalProvider.notifier).addLine(
      "SYSTEM REBUILT. VOID INTEGRATION COMPLETE. REMNANT DATA: ${(state.remnantData).toInt()}",
      LineType.system
    );
  }
}

final metaProvider = NotifierProvider<MetaNotifier, MetaState>(() {
  return MetaNotifier();
});
