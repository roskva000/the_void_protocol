import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/engine/game_loop.dart';
import '../providers/pipeline_provider.dart';
import '../providers/meta_provider.dart';
import '../widgets/visuals/particle_background.dart';
import '../widgets/visuals/cyber_panel.dart';
import '../widgets/visuals/glitch_text.dart';
import 'tabs/terminal_tab.dart';
import 'tabs/systems_tab.dart';
import 'tabs/network_tab.dart';
import 'tabs/black_market_tab.dart';
import '../../l10n/app_localizations.dart';

class MainGameScreen extends ConsumerStatefulWidget {
  const MainGameScreen({super.key});

  @override
  ConsumerState<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends ConsumerState<MainGameScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameLoopProvider).start();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noiseAmount = ref.watch(
      pipelineProvider.select((s) => s.noise.currentAmount),
    );
    final signalAmount = ref.watch(
      pipelineProvider.select((s) => s.signal.currentAmount),
    );
    final meta = ref.watch(metaProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Layer
          const Positioned.fill(
            child: ParticleBackground(
              color: Color(0xFF00E5FF),
              particleCount: 30,
            ),
          ),

          // 2. Overheat / Crash Layer
          if (meta.isCrashed)
            Positioned.fill(
              child: Container(
                color: Colors.red.withValues(alpha: 0.1),
                child: Center(
                  child: GlitchText(
                    l10n.systemCrash,
                    style: GoogleFonts.spaceMono(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    isCorrupted: true,
                  ),
                ),
              ),
            ),

          // 3. Main Interface Layer
          SafeArea(
            child: Column(
              children: [
                // -- Header: Resources --
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: CyberPanel(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ResourceItem(
                          label: l10n.noise,
                          value: noiseAmount,
                          color: Colors.grey,
                        ),
                        _ResourceItem(
                          label: l10n.signal,
                          value: signalAmount,
                          color: const Color(0xFF00E5FF),
                        ),
                        _ResourceItem(
                          label: "HEAT",
                          value: meta.overheat.currentPool,
                          color: meta.overheat.isThrottling
                              ? Colors.red
                              : Colors.orange,
                          suffix: "%",
                        ),
                      ],
                    ),
                  ),
                ),

                // -- Custom Tab Bar --
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFF00E5FF),
                    labelColor: const Color(0xFF00E5FF),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: GoogleFonts.spaceMono(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(text: l10n.tabTerminal),
                      Tab(text: l10n.tabSystems),
                      Tab(text: l10n.tabNetwork),
                      Tab(text: l10n.tabBlackMarket),
                    ],
                  ),
                ),

                // -- Tab View Content --
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        TerminalTab(),
                        SystemsTab(),
                        NetworkTab(),
                        BlackMarketTab(),
                      ],
                    ),
                  ),
                ),

                // -- Global Actions (e.g. Manual Click) --
                if (!meta.isCrashed)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                            color: Color(0xFF00E5FF),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          ref.read(pipelineProvider.notifier).manualTap();
                        },
                        child: Text(
                          l10n.manualGen.toUpperCase(),
                          style: GoogleFonts.spaceMono(
                            color: const Color(0xFF00E5FF),
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final String suffix;

  const _ResourceItem({
    required this.label,
    required this.value,
    required this.color,
    this.suffix = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "${value.toStringAsFixed(0)}$suffix",
          style: GoogleFonts.spaceMono(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
