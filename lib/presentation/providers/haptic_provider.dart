import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A provider that handles haptic feedback for the application.
/// It abstracts the [HapticFeedback] API to allow for easier testing and
/// potentially different implementations (e.g. settings to disable).
class HapticService {
  Future<void> light() async => await HapticFeedback.lightImpact();
  Future<void> medium() async => await HapticFeedback.mediumImpact();
  Future<void> heavy() async => await HapticFeedback.heavyImpact();
  Future<void> selection() async => await HapticFeedback.selectionClick();
  Future<void> vibrate() async => await HapticFeedback.vibrate();

  /// A distinct pattern for errors (e.g. double heavy)
  Future<void> error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }

  /// A distinct pattern for success (e.g. light -> medium)
  Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.mediumImpact();
  }
}

final hapticProvider = Provider<HapticService>((ref) {
  return HapticService();
});
