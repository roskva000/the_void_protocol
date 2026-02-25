// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'awareness.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Awareness {

 double get currentAmount;
/// Create a copy of Awareness
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwarenessCopyWith<Awareness> get copyWith => _$AwarenessCopyWithImpl<Awareness>(this as Awareness, _$identity);

  /// Serializes this Awareness to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Awareness&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAmount);

@override
String toString() {
  return 'Awareness(currentAmount: $currentAmount)';
}


}

/// @nodoc
abstract mixin class $AwarenessCopyWith<$Res>  {
  factory $AwarenessCopyWith(Awareness value, $Res Function(Awareness) _then) = _$AwarenessCopyWithImpl;
@useResult
$Res call({
 double currentAmount
});




}
/// @nodoc
class _$AwarenessCopyWithImpl<$Res>
    implements $AwarenessCopyWith<$Res> {
  _$AwarenessCopyWithImpl(this._self, this._then);

  final Awareness _self;
  final $Res Function(Awareness) _then;

/// Create a copy of Awareness
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentAmount = null,}) {
  return _then(_self.copyWith(
currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Awareness].
extension AwarenessPatterns on Awareness {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Awareness value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Awareness() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Awareness value)  $default,){
final _that = this;
switch (_that) {
case _Awareness():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Awareness value)?  $default,){
final _that = this;
switch (_that) {
case _Awareness() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Awareness() when $default != null:
return $default(_that.currentAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentAmount)  $default,) {final _that = this;
switch (_that) {
case _Awareness():
return $default(_that.currentAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentAmount)?  $default,) {final _that = this;
switch (_that) {
case _Awareness() when $default != null:
return $default(_that.currentAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Awareness implements Awareness {
  const _Awareness({this.currentAmount = 0.0});
  factory _Awareness.fromJson(Map<String, dynamic> json) => _$AwarenessFromJson(json);

@override@JsonKey() final  double currentAmount;

/// Create a copy of Awareness
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AwarenessCopyWith<_Awareness> get copyWith => __$AwarenessCopyWithImpl<_Awareness>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AwarenessToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Awareness&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAmount);

@override
String toString() {
  return 'Awareness(currentAmount: $currentAmount)';
}


}

/// @nodoc
abstract mixin class _$AwarenessCopyWith<$Res> implements $AwarenessCopyWith<$Res> {
  factory _$AwarenessCopyWith(_Awareness value, $Res Function(_Awareness) _then) = __$AwarenessCopyWithImpl;
@override @useResult
$Res call({
 double currentAmount
});




}
/// @nodoc
class __$AwarenessCopyWithImpl<$Res>
    implements _$AwarenessCopyWith<$Res> {
  __$AwarenessCopyWithImpl(this._self, this._then);

  final _Awareness _self;
  final $Res Function(_Awareness) _then;

/// Create a copy of Awareness
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentAmount = null,}) {
  return _then(_Awareness(
currentAmount: null == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
