import 'package:freezed_annotation/freezed_annotation.dart';

part 'awareness.freezed.dart';
part 'awareness.g.dart';

@freezed
abstract class Awareness with _$Awareness {
  const factory Awareness({@Default(0.0) double currentAmount}) = _Awareness;

  factory Awareness.fromJson(Map<String, dynamic> json) =>
      _$AwarenessFromJson(json);
}
