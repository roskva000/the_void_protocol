import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';
part 'filter.g.dart';

@freezed
abstract class Filter with _$Filter {
  const factory Filter({
    @Default(0) int count,
    @Default(10.0) double baseCapacityPerSecond,
    @Default(1.0) double efficiency, // F_eff
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}
