import 'package:flutter/material.dart';
import '../../theme/void_theme.dart';
import '../../../domain/entities/skill.dart';
import '../../../l10n/app_localizations.dart';

class SkillButton extends StatelessWidget {
  final Skill skill;
  final double cooldownProgress; // 0.0 to 1.0 (1.0 = full cooldown)
  final VoidCallback? onTap;
  final bool isAffordable;

  const SkillButton({
    super.key,
    required this.skill,
    required this.cooldownProgress,
    required this.onTap,
    required this.isAffordable,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnCooldown = cooldownProgress > 0;
    final bool isEnabled = !isOnCooldown && isAffordable;
    final l10n = AppLocalizations.of(context)!;

    final localizedName = _getName(l10n, skill.id);
    final localizedDesc = _getDesc(l10n, skill.id);

    return Tooltip(
      message: '$localizedName\n$localizedDesc\nCost: ${skill.cost} ${skill.costType}',
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: isEnabled
                  ? VoidTheme.neonCyan
                  : (isOnCooldown ? Colors.grey : Colors.red.withValues(alpha: 0.5)),
              width: 1,
            ),
            boxShadow: isEnabled
                ? [BoxShadow(color: VoidTheme.neonCyan.withValues(alpha: 0.5), blurRadius: 8)]
                : [],
          ),
          child: Stack(
            children: [
              // Icon / Text
              Center(
                child: Text(
                  _getInitials(localizedName),
                  style: TextStyle(
                    color: isEnabled ? VoidTheme.neonCyan : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier New',
                  ),
                ),
              ),

              // Cooldown Overlay
              if (isOnCooldown)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.7),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: cooldownProgress,
                        color: VoidTheme.neonCyan,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),

              // Cost Indicator (Simple)
              Positioned(
                bottom: 2,
                right: 2,
                child: Text(
                  '${skill.cost.toInt()}',
                  style: TextStyle(
                    fontSize: 8,
                    color: isAffordable ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    return name.split(' ').map((e) => e.isEmpty ? '' : e[0]).take(2).join();
  }

  String _getName(AppLocalizations l10n, String id) {
    switch (id) {
      case 'purge': return l10n.skillPurge;
      case 'stabilize': return l10n.skillStabilize;
      case 'overclock': return l10n.skillOverclock;
      default: return id;
    }
  }

  String _getDesc(AppLocalizations l10n, String id) {
    switch (id) {
      case 'purge': return l10n.skillPurgeDesc;
      case 'stabilize': return l10n.skillStabilizeDesc;
      case 'overclock': return l10n.skillOverclockDesc;
      default: return "";
    }
  }
}
