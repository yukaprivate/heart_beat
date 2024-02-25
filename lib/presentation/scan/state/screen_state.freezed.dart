// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScreenState {
  List<ScanResult> get scanResults => throw _privateConstructorUsedError;
  List<String> get identifier => throw _privateConstructorUsedError;
  Polar get polar => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  LoadingStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScreenStateCopyWith<ScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenStateCopyWith<$Res> {
  factory $ScreenStateCopyWith(
          ScreenState value, $Res Function(ScreenState) then) =
      _$ScreenStateCopyWithImpl<$Res, ScreenState>;
  @useResult
  $Res call(
      {List<ScanResult> scanResults,
      List<String> identifier,
      Polar polar,
      bool isLoading,
      LoadingStatus status});
}

/// @nodoc
class _$ScreenStateCopyWithImpl<$Res, $Val extends ScreenState>
    implements $ScreenStateCopyWith<$Res> {
  _$ScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scanResults = null,
    Object? identifier = null,
    Object? polar = null,
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      scanResults: null == scanResults
          ? _value.scanResults
          : scanResults // ignore: cast_nullable_to_non_nullable
              as List<ScanResult>,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as List<String>,
      polar: null == polar
          ? _value.polar
          : polar // ignore: cast_nullable_to_non_nullable
              as Polar,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScreenStateCopyWith<$Res>
    implements $ScreenStateCopyWith<$Res> {
  factory _$$_ScreenStateCopyWith(
          _$_ScreenState value, $Res Function(_$_ScreenState) then) =
      __$$_ScreenStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ScanResult> scanResults,
      List<String> identifier,
      Polar polar,
      bool isLoading,
      LoadingStatus status});
}

/// @nodoc
class __$$_ScreenStateCopyWithImpl<$Res>
    extends _$ScreenStateCopyWithImpl<$Res, _$_ScreenState>
    implements _$$_ScreenStateCopyWith<$Res> {
  __$$_ScreenStateCopyWithImpl(
      _$_ScreenState _value, $Res Function(_$_ScreenState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scanResults = null,
    Object? identifier = null,
    Object? polar = null,
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_$_ScreenState(
      scanResults: null == scanResults
          ? _value._scanResults
          : scanResults // ignore: cast_nullable_to_non_nullable
              as List<ScanResult>,
      identifier: null == identifier
          ? _value._identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as List<String>,
      polar: null == polar
          ? _value.polar
          : polar // ignore: cast_nullable_to_non_nullable
              as Polar,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ));
  }
}

/// @nodoc

class _$_ScreenState extends _ScreenState with DiagnosticableTreeMixin {
  const _$_ScreenState(
      {required final List<ScanResult> scanResults,
      required final List<String> identifier,
      required this.polar,
      required this.isLoading,
      required this.status})
      : _scanResults = scanResults,
        _identifier = identifier,
        super._();

  final List<ScanResult> _scanResults;
  @override
  List<ScanResult> get scanResults {
    if (_scanResults is EqualUnmodifiableListView) return _scanResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scanResults);
  }

  final List<String> _identifier;
  @override
  List<String> get identifier {
    if (_identifier is EqualUnmodifiableListView) return _identifier;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_identifier);
  }

  @override
  final Polar polar;
  @override
  final bool isLoading;
  @override
  final LoadingStatus status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ScreenState(scanResults: $scanResults, identifier: $identifier, polar: $polar, isLoading: $isLoading, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ScreenState'))
      ..add(DiagnosticsProperty('scanResults', scanResults))
      ..add(DiagnosticsProperty('identifier', identifier))
      ..add(DiagnosticsProperty('polar', polar))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScreenState &&
            const DeepCollectionEquality()
                .equals(other._scanResults, _scanResults) &&
            const DeepCollectionEquality()
                .equals(other._identifier, _identifier) &&
            (identical(other.polar, polar) || other.polar == polar) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_scanResults),
      const DeepCollectionEquality().hash(_identifier),
      polar,
      isLoading,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScreenStateCopyWith<_$_ScreenState> get copyWith =>
      __$$_ScreenStateCopyWithImpl<_$_ScreenState>(this, _$identity);
}

abstract class _ScreenState extends ScreenState {
  const factory _ScreenState(
      {required final List<ScanResult> scanResults,
      required final List<String> identifier,
      required final Polar polar,
      required final bool isLoading,
      required final LoadingStatus status}) = _$_ScreenState;
  const _ScreenState._() : super._();

  @override
  List<ScanResult> get scanResults;
  @override
  List<String> get identifier;
  @override
  Polar get polar;
  @override
  bool get isLoading;
  @override
  LoadingStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_ScreenStateCopyWith<_$_ScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}
