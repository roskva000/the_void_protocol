import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import '../../providers/meta_provider.dart';
import '../../providers/pipeline_provider.dart';
import '../../providers/anomaly_provider.dart';
import '../../providers/shake_provider.dart';
import '../../theme/void_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/visuals/glitch_text.dart';

class BlackMarketTab extends ConsumerWidget {
  const BlackMarketTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Center(
          child: GlitchText(
            l10n.tabBlackMarket,
            style: GoogleFonts.spaceMono(
              color: VoidTheme.errorRed,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Deal 1: Void Siphon
        _buildDealCard(
          context,
          ref,
          title: l10n.dealVoidSiphon,
          description: l10n.dealVoidSiphonDesc,
          cost: l10n.costStability(20),
          reward: l10n.rewardSignal(500),
          isRisky: false,
          onTap: () {
             final meta = ref.read(metaProvider);
             if (meta.stability >= 0.2) {
               ref.read(metaProvider.notifier).restoreStability(-0.2);
               ref.read(pipelineProvider.notifier).updateFromTick(
                 addedNoise: 0,
                 filterConsumed: 0,
                 addedSignal: 500,
               );
               _showToast(context, l10n.dealSuccess);
               HapticFeedback.mediumImpact();
             } else {
               _showToast(context, l10n.dealFail, isError: true);
               HapticFeedback.lightImpact();
             }
          },
        ),

        const SizedBox(height: 16),

        // Deal 2: Corrupt Data (High Risk)
        _buildDealCard(
          context,
          ref,
          title: l10n.dealCorruptData,
          description: l10n.dealCorruptDataDesc,
          cost: l10n.unknown,
          reward: l10n.rewardSignal(5000),
          isRisky: true,
          onTap: () {
             final activeAnomaly = ref.read(anomalyProvider).activeAnomaly;
             if (activeAnomaly != null) {
               _showToast(context, "SYSTEM LOCKDOWN: RESOLVE CURRENT ANOMALY", isError: true);
               HapticFeedback.heavyImpact();
               return;
             }

             ref.read(pipelineProvider.notifier).updateFromTick(
               addedNoise: 200, // Small noise cost
               filterConsumed: 0,
               addedSignal: 5000,
             );
             // Trigger Anomaly
             ref.read(anomalyProvider.notifier).spawnAnomaly();
             // Trigger Shake
             ref.read(shakeProvider.notifier).trigger(intensity: 15.0, duration: const Duration(milliseconds: 500));

             _showToast(context, l10n.anomalyDetected, isError: true);
             HapticFeedback.heavyImpact();
          },
        ),

        const SizedBox(height: 32),

        // Flavor Text / Lore
        Center(
          child: Text(
            l10n.fakeAd1,
            style: GoogleFonts.spaceMono(
              color: Colors.grey.withValues(alpha: 0.5),
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDealCard(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String description,
    required String cost,
    required String reward,
    required bool isRisky,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: isRisky ? VoidTheme.errorRed : VoidTheme.warningOrange,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (isRisky ? VoidTheme.errorRed : VoidTheme.warningOrange).withValues(alpha: 0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceMono(
                    color: isRisky ? VoidTheme.errorRed : VoidTheme.warningOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (isRisky)
                  const Icon(Icons.warning, color: VoidTheme.errorRed, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.spaceMono(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COST: $cost",
                  style: GoogleFonts.spaceMono(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "REWARD: $reward",
                  style: GoogleFonts.spaceMono(
                    color: VoidTheme.signalGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.spaceMono(color: isError ? Colors.white : Colors.black),
        ),
        backgroundColor: isError ? VoidTheme.errorRed : VoidTheme.signalGreen,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
