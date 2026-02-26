import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/utils/lifecycle_observer.dart';
import 'data/models/save_data_model.dart';
import 'data/repositories/local_storage_repository.dart';
import 'data/repositories/offline_progress_repository.dart';
import 'domain/entities/filter.dart';
import 'domain/entities/noise.dart';
import 'domain/entities/overheat.dart';
import 'domain/entities/signal.dart';
import 'domain/entities/awareness.dart';
import 'domain/entities/tech_tree.dart';
import 'l10n/app_localizations.dart';
import 'presentation/providers/meta_provider.dart';
import 'presentation/providers/pipeline_provider.dart';
import 'presentation/providers/upgrades_provider.dart';
import 'presentation/providers/locale_provider.dart';
import 'presentation/screens/boot_screen.dart';
import 'presentation/theme/void_theme.dart';
import 'presentation/widgets/visuals/scanline_overlay.dart';
import 'presentation/widgets/narrative/narrative_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorageRepository();
  await storage.init();
  final initialData = storage.load();

  runApp(
    ProviderScope(
      child: MainApp(initialData: initialData, storage: storage),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  final SaveDataModel? initialData;
  final LocalStorageRepository storage;

  const MainApp({super.key, required this.initialData, required this.storage});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late LifecycleObserver _lifecycleObserver;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyInitialData(widget.initialData);
    });

    _lifecycleObserver = LifecycleObserver(
      onPaused: _handleAppPaused,
      onResumed: _handleAppResumed,
    );
    _lifecycleObserver.setup();
  }

  @override
  void dispose() {
    _lifecycleObserver.dispose();
    super.dispose();
  }

  void _applyInitialData(SaveDataModel? data) {
    if (data == null) return;

    final techTree = TechTree(
      quantumSleepUnlocked: data.quantumSleepUnlocked,
      perfectIsolationUnlocked: data.perfectIsolationUnlocked,
      infiniteLoopUnlocked: data.infiniteLoopUnlocked,
      autoPurgeUnlocked: data.autoPurgeUnlocked,
      voiceOfHumanityUnlocked: data.voiceOfHumanityUnlocked,
      echoSynergyUnlocked: data.echoSynergyUnlocked,
      memoryRestorationUnlocked: data.memoryRestorationUnlocked,
      ethicsCoreUnlocked: data.ethicsCoreUnlocked,
      equilibriumDestructionUnlocked: data.equilibriumDestructionUnlocked,
      resonanceCoreUnlocked: data.resonanceCoreUnlocked,
      quantumOverclockUnlocked: data.quantumOverclockUnlocked,
      destructiveWillUnlocked: data.destructiveWillUnlocked,
    );

    // Apply MetaState
    ref
        .read(metaProvider.notifier)
        .setInitialState(
          MetaState(
            overheat: Overheat(currentPool: data.overheatPool),
            techTree: techTree,
            remnantData: 0.0,
            momentum: 1.0,
          ),
        );

    // Apply UpgradesState
    ref
        .read(upgradesProvider.notifier)
        .setInitialState(data.generatorCount, data.filterCount);

    // Apply PipelineState
    ref
        .read(pipelineProvider.notifier)
        .setInitialState(
          PipelineState(
            noise: Noise(currentAmount: data.noiseAmount),
            filter: Filter(),
            signal: Signal(currentAmount: data.signalAmount),
            awareness: Awareness(currentAmount: data.awarenessAmount),
          ),
        );

    // Apply Offline Progress if applicable
    if (data.lastExitTime != null) {
      final offlineRepo = OfflineProgressRepository();

      final upgrades = ref.read(upgradesProvider);
      final pipeline = ref.read(pipelineProvider);
      final meta = ref.read(metaProvider);

      final result = offlineRepo.calculateOfflineProgress(
        lastExitTime: data.lastExitTime!,
        resumeTime: DateTime.now(),
        baseNoiseProduction: pipeline.noise.baseProductionPerSecond,
        generatorCount: upgrades.generatorCount,
        baseFilterCapacity: pipeline.filter.baseCapacityPerSecond,
        filterCount: upgrades.filterCount,
        filterEfficiency: pipeline.filter.efficiency,
        currentNoiseState: pipeline.noise.currentAmount,
        isThrottling: meta.overheat.isThrottling,
        techTree: meta.techTree,
      );

      if (result.secondsElapsed > 0) {
        ref
            .read(pipelineProvider.notifier)
            .updateFromTick(
              addedNoise: result.noiseProduced,
              filterConsumed: result.filterConsumed,
              addedSignal: result.signalProduced,
            );
        if (result.overheatGenerated > 0) {
          ref
              .read(metaProvider.notifier)
              .tick(0.0, addedHeat: result.overheatGenerated);
        }
      }
    }
  }

  void _handleAppPaused() {
    final pipeline = ref.read(pipelineProvider);
    final upgrades = ref.read(upgradesProvider);
    final meta = ref.read(metaProvider);

    final saveData = SaveDataModel(
      noiseAmount: pipeline.noise.currentAmount,
      signalAmount: pipeline.signal.currentAmount,
      awarenessAmount: pipeline.awareness.currentAmount,
      overheatPool: meta.overheat.currentPool,
      generatorCount: upgrades.generatorCount,
      filterCount: upgrades.filterCount,
      lastExitTime: DateTime.now(),
      quantumSleepUnlocked: meta.techTree.quantumSleepUnlocked,
      perfectIsolationUnlocked: meta.techTree.perfectIsolationUnlocked,
      infiniteLoopUnlocked: meta.techTree.infiniteLoopUnlocked,
      autoPurgeUnlocked: meta.techTree.autoPurgeUnlocked,
      voiceOfHumanityUnlocked: meta.techTree.voiceOfHumanityUnlocked,
      echoSynergyUnlocked: meta.techTree.echoSynergyUnlocked,
      memoryRestorationUnlocked: meta.techTree.memoryRestorationUnlocked,
      ethicsCoreUnlocked: meta.techTree.ethicsCoreUnlocked,
      equilibriumDestructionUnlocked:
          meta.techTree.equilibriumDestructionUnlocked,
      resonanceCoreUnlocked: meta.techTree.resonanceCoreUnlocked,
      quantumOverclockUnlocked: meta.techTree.quantumOverclockUnlocked,
      destructiveWillUnlocked: meta.techTree.destructiveWillUnlocked,
    );

    widget.storage.save(saveData);
  }

  void _handleAppResumed() {
    final data = widget.storage.load();
    if (data?.lastExitTime != null) {
      final offlineRepo = OfflineProgressRepository();

      final upgrades = ref.read(upgradesProvider);
      final pipeline = ref.read(pipelineProvider);
      final meta = ref.read(metaProvider);

      final result = offlineRepo.calculateOfflineProgress(
        lastExitTime: data!.lastExitTime!,
        resumeTime: DateTime.now(),
        baseNoiseProduction: pipeline.noise.baseProductionPerSecond,
        generatorCount: upgrades.generatorCount,
        baseFilterCapacity: pipeline.filter.baseCapacityPerSecond,
        filterCount: upgrades.filterCount,
        filterEfficiency: pipeline.filter.efficiency,
        currentNoiseState: pipeline.noise.currentAmount,
        isThrottling: meta.overheat.isThrottling,
        techTree: meta.techTree,
      );

      if (result.secondsElapsed > 0) {
        // Integrate offline gains into current state
        ref
            .read(pipelineProvider.notifier)
            .updateFromTick(
              addedNoise: result.noiseProduced,
              filterConsumed: result.filterConsumed,
              addedSignal: result.signalProduced,
            );
        if (result.overheatGenerated > 0) {
          ref
              .read(metaProvider.notifier)
              .tick(0.0, addedHeat: result.overheatGenerated);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'The Void Protocol',
      theme: VoidTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            const NarrativeOverlay(),
            const Positioned.fill(
              child: IgnorePointer(
                child: ScanlineOverlay(opacity: 0.1),
              ),
            ),
          ],
        );
      },
      home: const BootScreen(),
    );
  }
}
