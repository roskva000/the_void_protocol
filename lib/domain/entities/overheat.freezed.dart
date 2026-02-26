// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overheat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Overheat {

 double get currentPool; double get maxTolerance;// O_max, 5% of memory capacity typically
 double get maxPool;// Hard crash limit
 bool get isThrottling;
/// Create a copy of Overheat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverheatCopyWith<Overheat> get copyWith => _$OverheatCopyWithImpl<Overheat>(this as Overheat, _$identity);

  /// Serializes this Overheat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Overheat&&(identical(other.currentPool, currentPool) || other.currentPool == currentPool)&&(identical(other.maxTolerance, maxTolerance) || other.maxTolerance == maxTolerance)&&(identical(other.maxPool, maxPool) || other.maxPool == maxPool)&&(identical(other.isThrottling, isThrottling) || other.isThrottling == isThrottling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPool,maxTolerance,maxPool,isThrottling);

@override
String toString() {
  return 'Overheat(currentPool: $currentPool, maxTolerance: $maxTolerance, maxPool: $maxPool, isThrottling: $isThrottling)';
}


}

/// @nodoc
abstract mixin class $OverheatCopyWith<$Res>  {
  factory $OverheatCopyWith(Overheat value, $Res Function(Overheat) _then) = _$OverheatCopyWithImpl;
@useResult
$Res call({
 double currentPool, double maxTolerance, double maxPool, bool isThrottling
});




}
/// @nodoc
class _$OverheatCopyWithImpl<$Res>
    implements $OverheatCopyWith<$Res> {
  _$OverheatCopyWithImpl(this._self, this._then);

  final Overheat _self;
  final $Res Function(Overheat) _then;

/// Create a copy of Overheat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPool = null,Object? maxTolerance = null,Object? maxPool = null,Object? isThrottling = null,}) {
  return _then(_self.copyWith(
currentPool: null == currentPool ? _self.currentPool : currentPool // ignore: cast_nullable_to_non_nullable
as double,maxTolerance: null == maxTolerance ? _self.maxTolerance : maxTolerance // ignore: cast_nullable_to_non_nullable
as double,maxPool: null == maxPool ? _self.maxPool : maxPool // ignore: cast_nullable_to_non_nullable
as double,isThrottling: null == isThrottling ? _self.isThrottling : isThrottling // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Overheat].
extension OverheatPatterns on Overheat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Overheat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Overheat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Overheat value)  $default,){
final _that = this;
switch (_that) {
case _Overheat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Overheat value)?  $default,){
final _that = this;
switch (_that) {
case _Overheat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentPool,  double maxTolerance,  double maxPool,  bool isThrottling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Overheat() when $default != null:
return $default(_that.currentPool,_that.maxTolerance,_that.maxPool,_that.isThrottling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentPool,  double maxTolerance,  double maxPool,  bool isThrottling)  $default,) {final _that = this;
switch (_that) {
case _Overheat():
return $default(_that.currentPool,_that.maxTolerance,_that.maxPool,_that.isThrottling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentPool,  double maxTolerance,  double maxPool,  bool isThrottling)?  $default,) {final _that = this;
switch (_that) {
case _Overheat() when $default != null:
return $default(_that.currentPool,_that.maxTolerance,_that.maxPool,_that.isThrottling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Overheat implements Overheat {
  const _Overheat({this.currentPool = 0.0, this.maxTolerance = 50.0, this.maxPool = 100.0, this.isThrottling = false});
  factory _Overheat.fromJson(Map<String, dynamic> json) => _$OverheatFromJson(json);

@override@JsonKey() final  double currentPool;
@override@JsonKey() final  double maxTolerance;
// O_max, 5% of memory capacity typically
@override@JsonKey() final  double maxPool;
// Hard crash limit
@override@JsonKey() final  bool isThrottling;

/// Create a copy of Overheat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OverheatCopyWith<_Overheat> get copyWith => __$OverheatCopyWithImpl<_Overheat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OverheatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Overheat&&(identical(other.currentPool, currentPool) || other.currentPool == currentPool)&&(identical(other.maxTolerance, maxTolerance) || other.maxTolerance == maxTolerance)&&(identical(other.maxPool, maxPool) || other.maxPool == maxPool)&&(identical(other.isThrottling, isThrottling) || other.isThrottling == isThrottling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPool,maxTolerance,maxPool,isThrottling);

@override
String toString() {
  return 'Overheat(currentPool: $currentPool, maxTolerance: $maxTolerance, maxPool: $maxPool, isThrottling: $isThrottling)';
}


}

/// @nodoc
abstract mixin class _$OverheatCopyWith<$Res> implements $OverheatCopyWith<$Res> {
  factory _$OverheatCopyWith(_Overheat value, $Res Function(_Overheat) _then) = __$OverheatCopyWithImpl;
@override @useResult
$Res call({
 double currentPool, double maxTolerance, double maxPool, bool isThrottling
});




}
/// @nodoc
class __$OverheatCopyWithImpl<$Res>
    implements _$OverheatCopyWith<$Res> {
  __$OverheatCopyWithImpl(this._self, this._then);

  final _Overheat _self;
  final $Res Function(_Overheat) _then;

/// Create a copy of Overheat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPool = null,Object? maxTolerance = null,Object? maxPool = null,Object? isThrottling = null,}) {
  return _then(_Overheat(
currentPool: null == currentPool ? _self.currentPool : currentPool // ignore: cast_nullable_to_non_nullable
as double,maxTolerance: null == maxTolerance ? _self.maxTolerance : maxTolerance // ignore: cast_nullable_to_non_nullable
as double,maxPool: null == maxPool ? _self.maxPool : maxPool // ignore: cast_nullable_to_non_nullable
as double,isThrottling: null == isThrottling ? _self.isThrottling : isThrottling // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
