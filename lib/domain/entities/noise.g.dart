// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Noise _$NoiseFromJson(Map<String, dynamic> json) => _Noise(
  currentAmount: (json['currentAmount'] as num?)?.toDouble() ?? 0.0,
  baseProductionPerSecond:
      (json['baseProductionPerSecond'] as num?)?.toDouble() ?? 1.0,
  generatorCount: (json['generatorCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$NoiseToJson(_Noise instance) => <String, dynamic>{
  'currentAmount': instance.currentAmount,
  'baseProductionPerSecond': instance.baseProductionPerSecond,
  'generatorCount': instance.generatorCount,
};
