// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Filter _$FilterFromJson(Map<String, dynamic> json) => _Filter(
  count: (json['count'] as num?)?.toInt() ?? 0,
  baseCapacityPerSecond:
      (json['baseCapacityPerSecond'] as num?)?.toDouble() ?? 10.0,
  efficiency: (json['efficiency'] as num?)?.toDouble() ?? 1.0,
);

Map<String, dynamic> _$FilterToJson(_Filter instance) => <String, dynamic>{
  'count': instance.count,
  'baseCapacityPerSecond': instance.baseCapacityPerSecond,
  'efficiency': instance.efficiency,
};
