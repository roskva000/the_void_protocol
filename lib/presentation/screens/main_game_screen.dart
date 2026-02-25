import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/engine/game_loop.dart';
import '../../core/utils/haptics.dart';
import '../providers/pipeline_provider.dart';
import '../providers/upgrades_provider.dart';
import '../providers/meta_provider.dart';
import '../providers/story_provider.dart';
import '../widgets/animated_number.dart';
import '../widgets/glass_panel.dart';
import '../widgets/story_log_widget.dart';

class MainGameScreen extends ConsumerStatefulWidget {
  const MainGameScreen({super.key});

  @override
  ConsumerState<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends ConsumerState<MainGameScreen> {
  bool _isPrestigeFlashing = false;

  @override
  void initState() {
    super.initState();
    // Start engine loop on boot
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameLoopProvider).start();
    });
  }

  void _showPrestigeFlash() {
    setState(() {
      _isPrestigeFlashing = true;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isPrestigeFlashing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Specifically watch the values we need to avoid rebuilding the entire screen.
    // E.g. ref.watch(pipelineProvider.select((state) => state.noise.currentAmount));
    final noiseAmount = ref.watch(
      pipelineProvider.select((s) => s.noise.currentAmount),
    );
    final signalAmount = ref.watch(
      pipelineProvider.select((s) => s.signal.currentAmount),
    );

    final generatorCount = ref.watch(
      upgradesProvider.select((s) => s.generatorCount),
    );
    final nextGenCost = ref.watch(
      upgradesProvider.select((s) => s.nextGeneratorCost),
    );

    final filterCount = ref.watch(
      upgradesProvider.select((s) => s.filterCount),
    );
    final nextFiltCost = ref.watch(
      upgradesProvider.select((s) => s.nextFilterCost),
    );

    final isThrottling = ref.watch(
      metaProvider.select((s) => s.overheat.isThrottling),
    );

    // Watch for Prestige triggers
    ref.listen(metaProvider.select((s) => s.remnantData), (prev, next) {
      if (prev != null && next > prev) {
        // Prestige occurred, Remnant Data increased!
        Haptics.heavy();
        _showPrestigeFlash();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.deepCharcoal,
      body: Stack(
        children: [
          // Basic Red Gradient for Overheat
          if (isThrottling)
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.glitchRed.withValues(alpha: 0.3),
                    ],
                    radius: 1.5,
                  ),
                ),
              ),
            ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- HEADER: Resource Pipeline ---
                  GlassPanel(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildResourceColumn(
                          'NOISE',
                          noiseAmount,
                          AppColors.textSecondary,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.neonBlue,
                          size: 16,
                        ),
                        _buildResourceColumn(
                          'SIGNAL',
                          signalAmount,
                          AppColors.neonBlue,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- BODY: Upgrades ---
                  Expanded(
                    child: GlassPanel(
                      child: Column(
                        children: [
                          Text(
                            'UPGRADES',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: AppColors.textPrimary,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Generator Purchase Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: AppColors.neonBlue),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                            ),
                            onPressed: () {
                              ref.read(pipelineProvider.notifier).manualTap();
                              Haptics.light();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Generate Noise (Manual)',
                                  style: GoogleFonts.spaceMono(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const Icon(
                                  Icons.touch_app,
                                  color: AppColors.neonBlue,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.glassWhite,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                            ),
                            onPressed: () {
                              bool success = ref
                                  .read(upgradesProvider.notifier)
                                  .buyGenerator();
                              if (success) {
                                Haptics.medium();
                              } else {
                                Haptics.error();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Generator LVL $generatorCount',
                                  style: GoogleFonts.inter(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'COST: ${nextGenCost.toStringAsFixed(0)}',
                                  style: GoogleFonts.spaceMono(
                                    color: AppColors.rustedBronze,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.glassWhite,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                            ),
                            onPressed: () {
                              bool success = ref
                                  .read(upgradesProvider.notifier)
                                  .buyFilter();
                              if (success) {
                                Haptics.medium();
                              } else {
                                Haptics.error();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Filter LVL $filterCount',
                                  style: GoogleFonts.inter(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'COST: ${nextFiltCost.toStringAsFixed(0)}',
                                  style: GoogleFonts.spaceMono(
                                    color: AppColors.rustedBronze,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Test button to force story log for debugging
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(storyProvider.notifier)
                                  .addLog("Hello World, I am awakening.");
                            },
                            child: const Text(
                              'Simulate Story Trigger',
                              style: TextStyle(color: Colors.white24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- FOOTER: Terminal Story Logs ---
          const Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: StoryLogWidget(),
          ),

          // --- PRESTIGE FLASH OVERLAY ---
          if (_isPrestigeFlashing)
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 100),
                builder: (context, val, child) {
                  return Opacity(
                    opacity: val,
                    child: Container(color: Colors.white),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResourceColumn(String label, double amount, Color accentColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedNumber(
          value: amount,
          style: GoogleFonts.spaceMono(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
      ],
    );
  }
}
