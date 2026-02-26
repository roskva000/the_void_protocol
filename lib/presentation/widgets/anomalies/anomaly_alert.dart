import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anomaly_provider.dart';

class AnomalyAlert extends ConsumerWidget {
  const AnomalyAlert({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show if active
    final isActive = ref.watch(anomalyProvider.select((s) => s.isActive));
    if (!isActive) return const SizedBox.shrink();

    return Positioned(
      top: 150, // Below header
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () {
          ref.read(anomalyProvider.notifier).resolveAnomaly();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.warning_amber_rounded, size: 40, color: Colors.white),
              SizedBox(height: 10),
              Text(
                "SYSTEM BREACH DETECTED",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'SpaceMono',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "TAP TO PURGE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'SpaceMono',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
