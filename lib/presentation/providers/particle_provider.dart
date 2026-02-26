import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticleEvent {
  final Offset position;
  final Color color;
  final int count;
  final DateTime timestamp;

  ParticleEvent({
    required this.position,
    required this.color,
    required this.count,
  }) : timestamp = DateTime.now();
}

class ParticleNotifier extends Notifier<ParticleEvent?> {
  @override
  ParticleEvent? build() {
    return null;
  }

  void burst({required Offset position, required Color color, int count = 20}) {
    state = ParticleEvent(position: position, color: color, count: count);
  }
}

final particleProvider = NotifierProvider<ParticleNotifier, ParticleEvent?>(() {
  return ParticleNotifier();
});
