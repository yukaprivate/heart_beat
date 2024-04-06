// ignore: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heart_beat/domain/home/screean_tab_enum.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:polar/polar.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  // ignore: unused_element
  const HomeState._();

  const factory HomeState({
    required ScreenTab currentTab,
  }) = _HomeState;

  // // 以下のメソッドはDTOなどJSONとDartのクラスを相互変換したい場合のみ残してください
  // factory HomeState.fromJson(Map<String, dynamic> json) =>
  //     _$ScreenStateFromJson(json);
}
