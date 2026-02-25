// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Signal _$SignalFromJson(Map<String, dynamic> json) => _Signal(
  currentAmount: (json['currentAmount'] as num?)?.toDouble() ?? 0.0,
  lifetimeProduced: (json['lifetimeProduced'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$SignalToJson(_Signal instance) => <String, dynamic>{
  'currentAmount': instance.currentAmount,
  'lifetimeProduced': instance.lifetimeProduced,
};
