import 'package:freezed_annotation/freezed_annotation.dart';

part 'overheat.freezed.dart';
part 'overheat.g.dart';

@freezed
abstract class Overheat with _$Overheat {
  const factory Overheat({
    @Default(0.0) double currentPool,
    @Default(50.0)
    double maxTolerance, // O_max, 5% of memory capacity typically
    @Default(false) bool isThrottling,
  }) = _Overheat;

  factory Overheat.fromJson(Map<String, dynamic> json) =>
      _$OverheatFromJson(json);
}
