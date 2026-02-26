import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundpool/soundpool.dart';

/// A provider that handles sound effects.
/// It uses [Soundpool] for low-latency playback of short UI sounds.
class SoundService {
  Soundpool? _pool;
  final Map<String, int> _soundIds = {};
  bool _muted = false;

  SoundService() {
    _init();
  }

  Future<void> _init() async {
    _pool = Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.notification),
    );

    // TODO(Sound): Load actual assets when available.
    // For now, we just prepare the map.
    // _soundIds['type'] = await _loadSound('assets/sounds/type.wav');
    // _soundIds['error'] = await _loadSound('assets/sounds/error.wav');
    // _soundIds['boot'] = await _loadSound('assets/sounds/boot.wav');
  }

  // Future<int> _loadSound(String path) async {
  //   if (_pool == null) return -1;
  //   try {
  //     final asset = await rootBundle.load(path);
  //     return await _pool!.load(asset);
  //   } catch (e) {
  //     // debugPrint('Error loading sound $path: $e');
  //     return -1;
  //   }
  // }

  void toggleMute() {
    _muted = !_muted;
  }

  Future<void> play(String soundId) async {
    if (_muted || _pool == null) return;

    // Fallback to system sound if "click" is requested and no asset loaded
    if (soundId == 'click' && !_soundIds.containsKey('click')) {
      await SystemSound.play(SystemSoundType.click);
      return;
    }

    final id = _soundIds[soundId];
    if (id != null && id != -1) {
      _pool!.play(id);
    }
  }

  /// Plays a random typing sound to simulate a mechanical keyboard
  Future<void> playTyping() async {
    // TODO(Sound): Implement random pitch/variation
    await play('type');
  }

  void dispose() {
    _pool?.dispose();
  }
}

final soundProvider = Provider<SoundService>((ref) {
  final service = SoundService();
  ref.onDispose(() => service.dispose());
  return service;
});
