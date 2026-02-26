import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/tech_tree_provider.dart';
import '../../providers/meta_provider.dart';
import '../../widgets/visuals/cyber_panel.dart';

class NetworkTab extends ConsumerWidget {
  const NetworkTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This grid shows TechNodes.
    // If a node is locked, it's gray.
    // If unlocked, it's green.
    // If purchasable (has prerequisites and money), it's selectable.

    final meta = ref.watch(metaProvider);
    final techNodes = ref.watch(techTreeProvider);
    final darkMatter = meta.remnantData;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
      ),
      itemCount: techNodes.length,
      itemBuilder: (context, index) {
        final node = techNodes[index];
        final canBuy =
            darkMatter >= node.cost &&
            node.prerequisites.every((pid) {
              final pNode = techNodes.firstWhere(
                (n) => n.id == pid,
                orElse: () => throw Exception("Prerequisite $pid not found"),
              );
              return pNode.unlocked;
            });

        return CyberPanel(
          isAlert: false,
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: (canBuy && !node.unlocked)
                ? () {
                    if (ref.read(metaProvider).remnantData >= node.cost) {
                      ref
                          .read(metaProvider.notifier)
                          .spendRemnantData(node.cost);
                      ref.read(techTreeProvider.notifier).unlock(node.id);
                    }
                  }
                : null,
            child: Container(
              color: node.unlocked
                  ? Colors.green.withValues(alpha: 0.1)
                  : (canBuy
                        ? Colors.blue.withValues(alpha: 0.1)
                        : Colors.black54),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    node.unlocked ? Icons.check_circle : Icons.lock,
                    color: node.unlocked ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    node.titleKey,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "DM: ${node.cost.toStringAsFixed(0)}",
                    style: GoogleFonts.spaceMono(
                      fontSize: 10,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
