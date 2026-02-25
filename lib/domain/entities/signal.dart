import 'package:freezed_annotation/freezed_annotation.dart';

part 'signal.freezed.dart';
part 'signal.g.dart';

@freezed
abstract class Signal with _$Signal {
  const factory Signal({
    @Default(0.0) double currentAmount,
    @Default(0.0) double lifetimeProduced,
  }) = _Signal;

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);
}
