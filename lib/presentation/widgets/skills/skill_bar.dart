import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/skill_provider.dart';
import '../../providers/meta_provider.dart';
import '../../providers/pipeline_provider.dart';
import 'skill_button.dart';

class SkillBar extends ConsumerWidget {
  const SkillBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillState = ref.watch(skillProvider);
    final skills = skillState.skills;
    final cooldowns = skillState.cooldowns;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: skills.map((skill) {
          final cooldown = cooldowns[skill.id] ?? 0.0;
          final cooldownProgress = cooldown > 0 ? (cooldown / skill.cooldownTime) : 0.0;

          // Check affordability
          bool isAffordable = false;
          final meta = ref.watch(metaProvider);
          final pipeline = ref.watch(pipelineProvider);

          switch (skill.costType) {
            case 'Stability':
              isAffordable = meta.stability >= skill.cost;
              break;
            case 'Signal':
              isAffordable = pipeline.signal.currentAmount >= skill.cost;
              break;
            case 'Heat':
              isAffordable = (meta.overheat.currentPool + skill.cost) <= 100.0;
              break;
            default:
              isAffordable = false;
          }

          return SkillButton(
            skill: skill,
            cooldownProgress: cooldownProgress,
            onTap: () {
              ref.read(skillProvider.notifier).activateSkill(skill.id);
            },
            isAffordable: isAffordable,
          );
        }).toList(),
      ),
    );
  }
}
