// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Noise {

 double get currentAmount; double get baseProductionPerSecond; int get generatorCount;
/// Create a copy of Noise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoiseCopyWith<Noise> get copyWith => _$NoiseCopyWithImpl<Noise>(this as Noise, _$identity);

  /// Serializes this Noise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Noise&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.baseProductionPerSecond, baseProductionPerSecond) || other.baseProductionPerSecond == baseProductionPerSecond)&&(identical(other.generatorCount, generatorCount) || other.generatorCount == generatorCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAmount,baseProductionPerSecond,generatorCount);

@override
String toString() {
  return 'Noise(currentAmount: $currentAmount, baseProductionPerSecond: $baseProductionPerSecond, generatorCount: $generatorCount)';
}


}

/// @nodoc
abstract mixin class $NoiseCopyWith<$Res>  {
  factory $NoiseCopyWith(Noise value, $Res Function(Noise) _then) = _$NoiseCopyWithImpl;
@useResult
$Res call({
 double currentAmount, double baseProductionPerSecond, int generatorCount
});




}
/// @nodoc
class _$NoiseCopyWithImpl<$Res>
    implements $NoiseCopyWith<$Res> {
  _$NoiseCopyWithImpl(this._self, this._then);

  final Noise _self;
  final $Res Function(Noise) _then;

/// Create a copy of Noise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentAmount = null,Object? baseProductionPerSecond = null,Object? generatorCount = null,}) {
  return _then(_self.copyWith(
currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double,baseProductionPerSecond: null == baseProductionPerSecond ? _self.baseProductionPerSecond : baseProductionPerSecond // ignore: cast_nullable_to_non_nullable
as double,generatorCount: null == generatorCount ? _self.generatorCount : generatorCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Noise].
extension NoisePatterns on Noise {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Noise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Noise() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Noise value)  $default,){
final _that = this;
switch (_that) {
case _Noise():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Noise value)?  $default,){
final _that = this;
switch (_that) {
case _Noise() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentAmount,  double baseProductionPerSecond,  int generatorCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Noise() when $default != null:
return $default(_that.currentAmount,_that.baseProductionPerSecond,_that.generatorCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentAmount,  double baseProductionPerSecond,  int generatorCount)  $default,) {final _that = this;
switch (_that) {
case _Noise():
return $default(_that.currentAmount,_that.baseProductionPerSecond,_that.generatorCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentAmount,  double baseProductionPerSecond,  int generatorCount)?  $default,) {final _that = this;
switch (_that) {
case _Noise() when $default != null:
return $default(_that.currentAmount,_that.baseProductionPerSecond,_that.generatorCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Noise implements Noise {
  const _Noise({this.currentAmount = 0.0, this.baseProductionPerSecond = 1.0, this.generatorCount = 0});
  factory _Noise.fromJson(Map<String, dynamic> json) => _$NoiseFromJson(json);

@override@JsonKey() final  double currentAmount;
@override@JsonKey() final  double baseProductionPerSecond;
@override@JsonKey() final  int generatorCount;

/// Create a copy of Noise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoiseCopyWith<_Noise> get copyWith => __$NoiseCopyWithImpl<_Noise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoiseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Noise&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.baseProductionPerSecond, baseProductionPerSecond) || other.baseProductionPerSecond == baseProductionPerSecond)&&(identical(other.generatorCount, generatorCount) || other.generatorCount == generatorCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAmount,baseProductionPerSecond,generatorCount);

@override
String toString() {
  return 'Noise(currentAmount: $currentAmount, baseProductionPerSecond: $baseProductionPerSecond, generatorCount: $generatorCount)';
}


}

/// @nodoc
abstract mixin class _$NoiseCopyWith<$Res> implements $NoiseCopyWith<$Res> {
  factory _$NoiseCopyWith(_Noise value, $Res Function(_Noise) _then) = __$NoiseCopyWithImpl;
@override @useResult
$Res call({
 double currentAmount, double baseProductionPerSecond, int generatorCount
});




}
/// @nodoc
class __$NoiseCopyWithImpl<$Res>
    implements _$NoiseCopyWith<$Res> {
  __$NoiseCopyWithImpl(this._self, this._then);

  final _Noise _self;
  final $Res Function(_Noise) _then;

/// Create a copy of Noise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentAmount = null,Object? baseProductionPerSecond = null,Object? generatorCount = null,}) {
  return _then(_Noise(
currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double,baseProductionPerSecond: null == baseProductionPerSecond ? _self.baseProductionPerSecond : baseProductionPerSecond // ignore: cast_nullable_to_non_nullable
as double,generatorCount: null == generatorCount ? _self.generatorCount : generatorCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
