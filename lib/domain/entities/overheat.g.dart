// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overheat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Overheat _$OverheatFromJson(Map<String, dynamic> json) => _Overheat(
  currentPool: (json['currentPool'] as num?)?.toDouble() ?? 0.0,
  maxTolerance: (json['maxTolerance'] as num?)?.toDouble() ?? 50.0,
  maxPool: (json['maxPool'] as num?)?.toDouble() ?? 100.0,
  isThrottling: json['isThrottling'] as bool? ?? false,
);

Map<String, dynamic> _$OverheatToJson(_Overheat instance) => <String, dynamic>{
  'currentPool': instance.currentPool,
  'maxTolerance': instance.maxTolerance,
  'maxPool': instance.maxPool,
  'isThrottling': instance.isThrottling,
};
