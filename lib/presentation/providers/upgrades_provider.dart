import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/cost_calculator.dart';

class UpgradesState {
  final int generatorCount;
  final int filterCount;

  // Cost tracking for UI
  final double nextGeneratorCost;
  final double nextFilterCost;

  const UpgradesState({
    this.generatorCount = 0,
    this.filterCount = 0,
    this.nextGeneratorCost = 10.0, // Base generator cost
    this.nextFilterCost = 50.0, // Base filter cost
  });

  UpgradesState copyWith({
    int? generatorCount,
    int? filterCount,
    double? nextGeneratorCost,
    double? nextFilterCost,
  }) {
    return UpgradesState(
      generatorCount: generatorCount ?? this.generatorCount,
      filterCount: filterCount ?? this.filterCount,
      nextGeneratorCost: nextGeneratorCost ?? this.nextGeneratorCost,
      nextFilterCost: nextFilterCost ?? this.nextFilterCost,
    );
  }
}

class UpgradesNotifier extends Notifier<UpgradesState> {
  // Base constants
  static const double baseGeneratorCost = 10.0;
  static const double generatorCostRate = 1.15;
  static const double baseFilterCost = 50.0;
  static const double filterCostRate = 1.20;

  @override
  UpgradesState build() {
    return const UpgradesState();
  }

  void setInitialState(int genCount, int filtCount) {
    state = UpgradesState(
      generatorCount: genCount,
      filterCount: filtCount,
      nextGeneratorCost: CostCalculator.getCost(
        baseGeneratorCost,
        generatorCostRate,
        genCount,
      ),
      nextFilterCost: CostCalculator.getCost(
        baseFilterCost,
        filterCostRate,
        filtCount,
      ),
    );
  }

  // Returns true if successful, false if not enough balance.
  // The UI should NOT check balance. The UI just calls this and reacts to the result.
  bool buyGenerator(double currentAwareness) {
    if (currentAwareness >= state.nextGeneratorCost) {
      int newCount = state.generatorCount + 1;
      state = state.copyWith(
        generatorCount: newCount,
        nextGeneratorCost: CostCalculator.getCost(
          baseGeneratorCost,
          generatorCostRate,
          newCount,
        ),
      );
      return true;
    }
    return false;
  }

  bool buyFilter(double currentAwareness) {
    if (currentAwareness >= state.nextFilterCost) {
      int newCount = state.filterCount + 1;
      state = state.copyWith(
        filterCount: newCount,
        nextFilterCost: CostCalculator.getCost(
          baseFilterCost,
          filterCostRate,
          newCount,
        ),
      );
      return true;
    }
    return false;
  }
}

final upgradesProvider = NotifierProvider<UpgradesNotifier, UpgradesState>(() {
  return UpgradesNotifier();
});
