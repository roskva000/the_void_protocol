import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/cost_calculator.dart';
import 'pipeline_provider.dart';

class UpgradesState {
  final int generatorCount;
  final int filterCount;

  // Cost tracking for UI
  final double nextGeneratorCost;
  final double nextFilterCost;

  const UpgradesState({
    this.generatorCount = 1,
    this.filterCount = 1,
    this.nextGeneratorCost = 11.5, // Base 10.0 * 1.15^1
    this.nextFilterCost = 60.0, // Base 50.0 * 1.20^1
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
  // We use `ref.read` to get the current signal and spend it automatically.
  bool buyGenerator() {
    final currentSignal = ref.read(pipelineProvider).signal.currentAmount;
    if (currentSignal >= state.nextGeneratorCost) {
      // Spend the signal
      ref.read(pipelineProvider.notifier).spendSignal(state.nextGeneratorCost);

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

  bool buyFilter() {
    final currentSignal = ref.read(pipelineProvider).signal.currentAmount;
    if (currentSignal >= state.nextFilterCost) {
      // Spend the signal
      ref.read(pipelineProvider.notifier).spendSignal(state.nextFilterCost);

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
