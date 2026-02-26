import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/skill.dart';
import 'meta_provider.dart';
import 'pipeline_provider.dart';

class SkillState {
  final Map<String, double> cooldowns; // Skill ID -> Seconds remaining
  final List<Skill> skills;

  const SkillState({
    this.cooldowns = const {},
    this.skills = const [],
  });

  SkillState copyWith({
    Map<String, double>? cooldowns,
    List<Skill>? skills,
  }) {
    return SkillState(
      cooldowns: cooldowns ?? this.cooldowns,
      skills: skills ?? this.skills,
    );
  }
}

class SkillNotifier extends Notifier<SkillState> {
  @override
  SkillState build() {
    return const SkillState(
      skills: [
        Skill(
          id: 'purge',
          name: 'System Purge',
          description: 'Clears 50% of Noise but destabilizes the core.',
          cooldownTime: 60.0,
          cost: 0.1,
          costType: 'Stability',
          isUnlocked: true,
        ),
        Skill(
          id: 'stabilize',
          name: 'Quantum Stabilization',
          description: 'Restores 25% Stability using Signal coherence.',
          cooldownTime: 120.0,
          cost: 1000.0,
          costType: 'Signal',
          isUnlocked: true,
        ),
        Skill(
          id: 'overclock',
          name: 'Forced Overclock',
          description: 'Boosts global speed by 200% for 15s. Generates massive Heat.',
          cooldownTime: 180.0,
          cost: 40.0,
          costType: 'Heat',
          isUnlocked: true,
        ),
      ],
    );
  }

  void tick(double dt) {
    if (state.cooldowns.isEmpty) return;

    final newCooldowns = <String, double>{};
    state.cooldowns.forEach((id, time) {
      if (time > 0) {
        newCooldowns[id] = time - dt;
        if (newCooldowns[id]! < 0) newCooldowns[id] = 0;
      }
    });

    state = state.copyWith(cooldowns: newCooldowns);
  }

  bool canUseSkill(Skill skill) {
    final cooldown = state.cooldowns[skill.id] ?? 0.0;
    if (cooldown > 0) return false;

    final meta = ref.read(metaProvider);
    final pipeline = ref.read(pipelineProvider);

    if (meta.isCrashed) return false;

    switch (skill.costType) {
      case 'Stability':
        return meta.stability >= skill.cost;
      case 'Signal':
        return pipeline.signal.currentAmount >= skill.cost;
      case 'Heat':
        // Allow risky moves that might crash the system immediately
        return true;
      default:
        return false;
    }
  }

  void activateSkill(String skillId) {
    final skill = state.skills.firstWhere((s) => s.id == skillId);
    if (!canUseSkill(skill)) return;

    // Apply Cost
    switch (skill.costType) {
      case 'Stability':
        ref.read(metaProvider.notifier).restoreStability(-skill.cost);
        break;
      case 'Signal':
        ref.read(pipelineProvider.notifier).spendSignal(skill.cost);
        break;
      case 'Heat':
        ref.read(metaProvider.notifier).tick(0, addedHeat: skill.cost);
        break;
    }

    // Apply Effect
    switch (skillId) {
      case 'purge':
        final currentNoise = ref.read(pipelineProvider).noise.currentAmount;
        ref.read(pipelineProvider.notifier).updateFromTick(
          addedNoise: -(currentNoise * 0.5), // Remove 50%
          filterConsumed: 0,
          addedSignal: 0,
        );
        break;
      case 'stabilize':
        ref.read(metaProvider.notifier).restoreStability(0.25);
        break;
      case 'overclock':
        ref.read(metaProvider.notifier).addMomentum(2.0);
        // Note: Momentum decays naturally over time in MetaNotifier
        break;
    }

    // Set Cooldown
    final newCooldowns = Map<String, double>.from(state.cooldowns);
    newCooldowns[skillId] = skill.cooldownTime;
    state = state.copyWith(cooldowns: newCooldowns);
  }
}

final skillProvider = NotifierProvider<SkillNotifier, SkillState>(() {
  return SkillNotifier();
});
