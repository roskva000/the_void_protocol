import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/anomaly_provider.dart';
import '../../providers/particle_provider.dart';
import '../../providers/shake_provider.dart';
import '../../theme/void_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'minigame_dialog.dart';

class AnomalyAlert extends ConsumerWidget {
  const AnomalyAlert({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anomalyState = ref.watch(anomalyProvider);
    final anomaly = anomalyState.activeAnomaly;
    final timeRemaining = anomalyState.timeRemaining;
    final l10n = AppLocalizations.of(context)!;

    if (anomaly == null) return const SizedBox.shrink();

    return Positioned(
      top: 100, // Below header
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SymbolMatchMinigame(
              onSuccess: () {
                Navigator.of(context).pop();
                ref.read(anomalyProvider.notifier).resolveAnomaly();
                HapticFeedback.mediumImpact();
                ref.read(particleProvider.notifier).burst(position: const Offset(200, 200), color: VoidTheme.signalGreen, count: 50);
              },
              onFailure: () {
                Navigator.of(context).pop();
                ref.read(anomalyProvider.notifier).failAnomaly();
                HapticFeedback.heavyImpact();
                // Shake is triggered by MetaNotifier listener in MainGameScreen, wait no, Anomaly failure doesn't crash meta usually.
                // We should trigger shake manually here if needed.
                ref.read(shakeProvider.notifier).trigger(intensity: 20.0, duration: const Duration(milliseconds: 500));
                ref.read(particleProvider.notifier).burst(position: const Offset(200, 200), color: VoidTheme.errorRed, count: 50);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.9),
            border: Border.all(color: Colors.redAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${l10n.anomalyDetected}: ${_getTitle(l10n, anomaly.id).toUpperCase()}",
                      style: GoogleFonts.spaceMono(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _getDesc(l10n, anomaly.id),
                      style: GoogleFonts.spaceMono(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "${l10n.breachProtocol} - ${timeRemaining.toStringAsFixed(1)}s",
                      style: GoogleFonts.spaceMono(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle(AppLocalizations l10n, String id) {
    switch (id) {
      case 'data_corruption': return l10n.anomalyDataCorruption;
      case 'void_leak': return l10n.anomalyVoidLeak;
      case 'temporal_rift': return l10n.anomalyTemporalRift;
      default: return id;
    }
  }

  String _getDesc(AppLocalizations l10n, String id) {
    switch (id) {
      case 'data_corruption': return l10n.descDataCorruption;
      case 'void_leak': return l10n.descVoidLeak;
      case 'temporal_rift': return l10n.descTemporalRift;
      default: return "";
    }
  }
}
