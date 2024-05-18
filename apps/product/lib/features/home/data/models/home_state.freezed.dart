// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  bool get loading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  Position? get currentPosition => throw _privateConstructorUsedError;
  WeatherToDisplay? get currentWeather => throw _privateConstructorUsedError;
  WeatherToDisplayByCity? get currentSearchWeather =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {bool loading,
      bool hasError,
      Position? currentPosition,
      WeatherToDisplay? currentWeather,
      WeatherToDisplayByCity? currentSearchWeather});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? hasError = null,
    Object? currentPosition = freezed,
    Object? currentWeather = freezed,
    Object? currentSearchWeather = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      currentWeather: freezed == currentWeather
          ? _value.currentWeather
          : currentWeather // ignore: cast_nullable_to_non_nullable
              as WeatherToDisplay?,
      currentSearchWeather: freezed == currentSearchWeather
          ? _value.currentSearchWeather
          : currentSearchWeather // ignore: cast_nullable_to_non_nullable
              as WeatherToDisplayByCity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool hasError,
      Position? currentPosition,
      WeatherToDisplay? currentWeather,
      WeatherToDisplayByCity? currentSearchWeather});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? hasError = null,
    Object? currentPosition = freezed,
    Object? currentWeather = freezed,
    Object? currentSearchWeather = freezed,
  }) {
    return _then(_$HomeStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: freezed == currentPosition
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as Position?,
      currentWeather: freezed == currentWeather
          ? _value.currentWeather
          : currentWeather // ignore: cast_nullable_to_non_nullable
              as WeatherToDisplay?,
      currentSearchWeather: freezed == currentSearchWeather
          ? _value.currentSearchWeather
          : currentSearchWeather // ignore: cast_nullable_to_non_nullable
              as WeatherToDisplayByCity?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  _$HomeStateImpl(
      {required this.loading,
      required this.hasError,
      required this.currentPosition,
      required this.currentWeather,
      required this.currentSearchWeather});

  @override
  final bool loading;
  @override
  final bool hasError;
  @override
  final Position? currentPosition;
  @override
  final WeatherToDisplay? currentWeather;
  @override
  final WeatherToDisplayByCity? currentSearchWeather;

  @override
  String toString() {
    return 'HomeState(loading: $loading, hasError: $hasError, currentPosition: $currentPosition, currentWeather: $currentWeather, currentSearchWeather: $currentSearchWeather)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.currentWeather, currentWeather) ||
                other.currentWeather == currentWeather) &&
            (identical(other.currentSearchWeather, currentSearchWeather) ||
                other.currentSearchWeather == currentSearchWeather));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, hasError,
      currentPosition, currentWeather, currentSearchWeather);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
          {required final bool loading,
          required final bool hasError,
          required final Position? currentPosition,
          required final WeatherToDisplay? currentWeather,
          required final WeatherToDisplayByCity? currentSearchWeather}) =
      _$HomeStateImpl;

  @override
  bool get loading;
  @override
  bool get hasError;
  @override
  Position? get currentPosition;
  @override
  WeatherToDisplay? get currentWeather;
  @override
  WeatherToDisplayByCity? get currentSearchWeather;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
