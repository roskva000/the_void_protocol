import 'package:freezed_annotation/freezed_annotation.dart';

part 'noise.freezed.dart';
part 'noise.g.dart';

@freezed
abstract class Noise with _$Noise {
  const factory Noise({
    @Default(0.0) double currentAmount,
    @Default(1.0) double baseProductionPerSecond,
    @Default(0) int generatorCount,
  }) = _Noise;

  factory Noise.fromJson(Map<String, dynamic> json) => _$NoiseFromJson(json);
}
