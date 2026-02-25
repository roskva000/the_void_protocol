import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pipeline_provider.dart';

class PrestigeNotifier extends Notifier<double> {
  @override
  double build() {
    return 0.0;
  }

  // Calculate potential Dark Matter gain
  double calculatePotentialPrestige() {
    final lifetimeSignal = ref.read(pipelineProvider).signal.lifetimeProduced;
    if (lifetimeSignal < 1000) return 0.0;
    // Formula: (Lifetime Signal / 1000) ^ 0.5
    return (lifetimeSignal / 1000); // Simplified for now
  }
}

final prestigeProvider = NotifierProvider<PrestigeNotifier, double>(() {
  return PrestigeNotifier();
});
