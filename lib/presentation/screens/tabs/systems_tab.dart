import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/upgrades_provider.dart';
import '../../providers/meta_provider.dart';
import '../../widgets/visuals/cyber_panel.dart';
import '../../../l10n/app_localizations.dart';

class SystemsTab extends ConsumerWidget {
  const SystemsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upgrades = ref.watch(upgradesProvider);
    final meta = ref.watch(metaProvider);
    final l10n = AppLocalizations.of(context)!;

    final genCost = upgrades.nextGeneratorCost;
    final filtCost = upgrades.nextFilterCost;
    final isCrashed = meta.isCrashed;

    return Column(
      children: [
        // Generators
        CyberPanel(
          child: ListTile(
            title: Text(
              l10n.genLvl(upgrades.generatorCount),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
            ),
            subtitle: Text(
              l10n.cost(genCost.toStringAsFixed(0)),
              style: GoogleFonts.spaceMono(color: Colors.grey, fontSize: 12),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCrashed ? Colors.grey : Colors.blueAccent,
              ),
              onPressed: isCrashed
                  ? null
                  : () {
                      // ignore: unused_local_variable
                      final success =
                          ref.read(upgradesProvider.notifier).buyGenerator();
                      // TODO: Haptics
                    },
              child: Text(l10n.buy),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Filters
        CyberPanel(
          child: ListTile(
            title: Text(
              l10n.filterLvl(upgrades.filterCount),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
            ),
            subtitle: Text(
              l10n.cost(filtCost.toStringAsFixed(0)),
              style: GoogleFonts.spaceMono(color: Colors.grey, fontSize: 12),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isCrashed ? Colors.grey : Colors.blueAccent,
              ),
              onPressed: isCrashed
                  ? null
                  : () {
                      // ignore: unused_local_variable
                      final success =
                          ref.read(upgradesProvider.notifier).buyFilter();
                      // TODO: Haptics
                    },
              child: Text(l10n.buy),
            ),
          ),
        ),
      ],
    );
  }
}
