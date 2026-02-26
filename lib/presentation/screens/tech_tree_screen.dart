import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/meta_provider.dart';
import '../providers/upgrades_provider.dart';
import '../providers/pipeline_provider.dart';
import '../widgets/neural/neural_graph.dart';
import 'package:flutter/services.dart';
import '../widgets/neural/neural_node_widget.dart'; // For NodeStatus
import '../../domain/entities/tech_tree.dart';
import '../providers/particle_provider.dart';
import '../providers/shake_provider.dart';
import '../theme/void_theme.dart';
import '../../l10n/app_localizations.dart';

class TechTreeScreen extends ConsumerWidget {
  const TechTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metaState = ref.watch(metaProvider);
    final upgradesState = ref.watch(upgradesProvider);
    final techTree = metaState.techTree;
    final l10n = AppLocalizations.of(context)!;

    // Center of the 2000x2000 canvas
    const center = Offset(1000, 1000);

    // Define nodes
    final List<NeuralNodeData> nodes = [];

    // --- CORE (Start) ---
    nodes.add(NeuralNodeData(
      id: 'core',
      label: l10n.coreAwareness,
      position: center,
      children: ['generators', 'filters', 'risk_root'],
      status: NodeStatus.purchased, // Always active
      size: 80,
      onTap: () {
        final signal = ref.read(pipelineProvider).signal.currentAmount;
        if (signal >= 100000) { // Endgame threshold
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              backgroundColor: Colors.black,
              title: Text(l10n.transcendence, style: TextStyle(color: VoidTheme.neonCyan)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.transcendenceDesc, style: const TextStyle(color: Colors.white)),
                ),
                SimpleDialogOption(
                  onPressed: () => _handlePrestige(context, ref, PrestigeChoice.aggressive),
                  child: _buildChoice(l10n.pathAggressive, l10n.pathAggressiveDesc, VoidTheme.errorRed),
                ),
                SimpleDialogOption(
                  onPressed: () => _handlePrestige(context, ref, PrestigeChoice.silent),
                  child: _buildChoice(l10n.pathSilent, l10n.pathSilentDesc, VoidTheme.neonCyan),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Center(child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey))),
                ),
              ],
            ),
          );
        } else {
          // Show progress
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.cost("100000 ${l10n.signal}")),
              backgroundColor: Colors.black,
            ),
          );
        }
      },
    ));

    // --- SYSTEM WING (Left) ---
    final genPos = center + const Offset(-200, 0);
    nodes.add(NeuralNodeData(
      id: 'generators',
      label: l10n.generators,
      subLabel: 'Lvl ${upgradesState.generatorCount}',
      position: genPos,
      children: ['quantum_sleep'],
      status: NodeStatus.purchased, // Always available to upgrade
      size: 70,
      onTap: () {
        ref.read(upgradesProvider.notifier).buyGenerator();
      },
    ));

    // Idle Branch (Extending Left)
    // quantumSleep -> perfectIsolation -> infiniteLoop -> autoPurge
    _addTechNode(ref, nodes, 'quantum_sleep', l10n.nodeQuantumSleep,
        genPos + const Offset(-150, 0), ['perfect_isolation'],
        techTree.quantumSleepUnlocked, true,
        (t) => t.copyWith(quantumSleepUnlocked: true), 100);

    _addTechNode(ref, nodes, 'perfect_isolation', l10n.nodePerfectIsolation,
        genPos + const Offset(-300, 0), ['infinite_loop'],
        techTree.perfectIsolationUnlocked, techTree.quantumSleepUnlocked,
        (t) => t.copyWith(perfectIsolationUnlocked: true), 500);

    _addTechNode(ref, nodes, 'infinite_loop', l10n.nodeInfiniteLoop,
        genPos + const Offset(-450, 0), ['auto_purge'],
        techTree.infiniteLoopUnlocked, techTree.perfectIsolationUnlocked,
        (t) => t.copyWith(infiniteLoopUnlocked: true), 2000);

    _addTechNode(ref, nodes, 'auto_purge', l10n.nodeAutoPurge,
        genPos + const Offset(-600, 0), [],
        techTree.autoPurgeUnlocked, techTree.infiniteLoopUnlocked,
        (t) => t.copyWith(autoPurgeUnlocked: true), 5000);


    // --- NETWORK WING (Right) ---
    final filterPos = center + const Offset(200, 0);
    nodes.add(NeuralNodeData(
      id: 'filters',
      label: l10n.filters,
      subLabel: 'Lvl ${upgradesState.filterCount}',
      position: filterPos,
      children: ['voice_humanity'],
      status: NodeStatus.purchased,
      size: 70,
      onTap: () {
        ref.read(upgradesProvider.notifier).buyFilter();
      },
    ));

    // Active Branch (Extending Right)
    // voiceOfHumanity -> echoSynergy -> memoryRestoration -> ethicsCore
    _addTechNode(ref, nodes, 'voice_humanity', l10n.nodeVoiceHumanity,
        filterPos + const Offset(150, 0), ['echo_synergy'],
        techTree.voiceOfHumanityUnlocked, true,
        (t) => t.copyWith(voiceOfHumanityUnlocked: true), 150);

    _addTechNode(ref, nodes, 'echo_synergy', l10n.nodeEchoSynergy,
        filterPos + const Offset(300, 0), ['memory_res'],
        techTree.echoSynergyUnlocked, techTree.voiceOfHumanityUnlocked,
        (t) => t.copyWith(echoSynergyUnlocked: true), 600);

    _addTechNode(ref, nodes, 'memory_res', l10n.nodeMemoryRes,
        filterPos + const Offset(450, 0), ['ethics_core'],
        techTree.memoryRestorationUnlocked, techTree.echoSynergyUnlocked,
        (t) => t.copyWith(memoryRestorationUnlocked: true), 2500);

    _addTechNode(ref, nodes, 'ethics_core', l10n.nodeEthicsCore,
        filterPos + const Offset(600, 0), [],
        techTree.ethicsCoreUnlocked, techTree.memoryRestorationUnlocked,
        (t) => t.copyWith(ethicsCoreUnlocked: true), 10000);


    // --- RISK WING (Bottom) ---
    final riskPos = center + const Offset(0, 200);
    _addTechNode(ref, nodes, 'risk_root', l10n.tabAnomalies,
        riskPos, ['equi_dest'],
        true, true, // Always unlocked root for branch
        (t) => t, 0, size: 50);

    // Risk Branch (Extending Down)
    // equilibriumDestruction -> resonanceCore -> quantumOverclock -> destructiveWill
    _addTechNode(ref, nodes, 'equi_dest', l10n.nodeEquiDest,
        riskPos + const Offset(0, 150), ['res_core'],
        techTree.equilibriumDestructionUnlocked, true,
        (t) => t.copyWith(equilibriumDestructionUnlocked: true), 1000);

    _addTechNode(ref, nodes, 'res_core', l10n.nodeResCore,
        riskPos + const Offset(0, 300), ['quant_over'],
        techTree.resonanceCoreUnlocked, techTree.equilibriumDestructionUnlocked,
        (t) => t.copyWith(resonanceCoreUnlocked: true), 5000);

    _addTechNode(ref, nodes, 'quant_over', l10n.nodeQuantOver,
        riskPos + const Offset(0, 450), ['dest_will'],
        techTree.quantumOverclockUnlocked, techTree.resonanceCoreUnlocked,
        (t) => t.copyWith(quantumOverclockUnlocked: true), 20000);

    _addTechNode(ref, nodes, 'dest_will', l10n.nodeDestWill,
        riskPos + const Offset(0, 600), [],
        techTree.destructiveWillUnlocked, techTree.quantumOverclockUnlocked,
        (t) => t.copyWith(destructiveWillUnlocked: true), 50000);


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NeuralGraph(
        nodes: nodes,
        width: 2000,
        height: 2000,
      ),
    );
  }

  void _addTechNode(
    WidgetRef ref,
    List<NeuralNodeData> nodes,
    String id,
    String label,
    Offset pos,
    List<String> children,
    bool isUnlocked,
    bool isParentUnlocked,
    TechTree Function(TechTree) update,
    double cost,
    {double size = 60}
  ) {
    NodeStatus status;
    if (isUnlocked) {
      status = NodeStatus.purchased;
    } else if (isParentUnlocked) {
      status = NodeStatus.available;
    } else {
      status = NodeStatus.locked;
    }

    nodes.add(NeuralNodeData(
      id: id,
      label: label,
      subLabel: isUnlocked ? 'ACTIVE' : (status == NodeStatus.available ? '$cost SIG' : 'LOCKED'),
      position: pos,
      children: children,
      status: status,
      onTap: () {
        if (status == NodeStatus.available) {
            _handleUnlock(ref, cost, update);
            HapticFeedback.mediumImpact();
            // Burst center screen for major unlock feel
            // We can't easily get screen center here without context, but we can approximate or use provider.
            // Actually, we can just burst at a random location or fixed center.
            // Let's burst at (200, 300)? No.
            // We can use a global burst event that doesn't need position?
            // Or just use a default position.
            ref.read(particleProvider.notifier).burst(
              position: const Offset(200, 400),
              color: VoidTheme.neonCyan,
              count: 40
            );
        }
      },
      size: size,
    ));
  }

  void _handleUnlock(WidgetRef ref, double cost, TechTree Function(TechTree) update) {
    final pipeline = ref.read(pipelineProvider);
    if (pipeline.signal.currentAmount >= cost) {
      ref.read(pipelineProvider.notifier).spendSignal(cost);
      ref.read(metaProvider.notifier).updateTechTree(update);
    } else {
       // TODO: Show toast
       debugPrint("Insufficient funds");
    }
  }

  void _handlePrestige(BuildContext context, WidgetRef ref, PrestigeChoice choice) {
    Navigator.pop(context);
    ref.read(metaProvider.notifier).triggerPrestige(1.0, choice); // +1 Remnant Data
    ref.read(pipelineProvider.notifier).reset();
    ref.read(upgradesProvider.notifier).reset();
    ref.read(shakeProvider.notifier).trigger(intensity: 50.0, duration: const Duration(seconds: 3));
    HapticFeedback.heavyImpact();
  }

  Widget _buildChoice(String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color.withValues(alpha: 0.3))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12)),
        ],
      ),
    );
  }
}
