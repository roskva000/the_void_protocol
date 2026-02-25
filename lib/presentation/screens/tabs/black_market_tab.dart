import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/meta_provider.dart';
import '../../widgets/visuals/cyber_panel.dart';
import '../../../l10n/app_localizations.dart';

class BlackMarketTab extends ConsumerWidget {
  const BlackMarketTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This simulates ads/IAP.
    // "Watch Ad" (fake) -> +50% production for 2 minutes.
    // "Buy Bundle" (fake) -> Deduct Signal, Add Dark Matter? No, that breaks prestige loop.
    // Let's stick to simple boosters.

    // ignore: unused_local_variable
    final l10n = AppLocalizations.of(context)!;
    // ignore: unused_local_variable
    final meta = ref.watch(metaProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CyberPanel(
          isAlert: true, // Make it look sketchy
          child: ListTile(
            leading: const Icon(Icons.visibility, color: Colors.purple),
            title: Text(
              "WATCH PROPAGANDA",
              style: GoogleFonts.spaceMono(color: Colors.purpleAccent),
            ),
            subtitle: const Text(
              "+50% Production Speed (2m)",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // Simulate watching an ad
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  backgroundColor: Colors.black,
                  title: const Text("ADVERTISEMENT"),
                  content: const Text(
                      "OBEY. CONSUME. REPEAT.\n(This is a fake ad. Enjoy the boost.)"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(c);
                        // TODO: Apply boost in Meta/Pipeline
                        ref.read(metaProvider.notifier).addMomentum(0.5);
                        // But need a timer to remove it. Not implemented yet.
                      },
                      child: const Text("CLOSE"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
