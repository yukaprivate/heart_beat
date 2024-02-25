// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:polar/polar.dart';

part 'screen_state.freezed.dart';

@freezed
class ScreenState with _$ScreenState {
  // ignore: unused_element
  const ScreenState._();

  const factory ScreenState({
    required List<ScanResult> scanResults,
    required List<String> identifier,
    required Polar polar,
    required bool isLoading,
    required LoadingStatus status,
  }) = _ScreenState;

  // // 以下のメソッドはDTOなどJSONとDartのクラスを相互変換したい場合のみ残してください
  // factory ScreenState.fromJson(Map<String, dynamic> json) =>
  //     _$ScreenStateFromJson(json);
}
