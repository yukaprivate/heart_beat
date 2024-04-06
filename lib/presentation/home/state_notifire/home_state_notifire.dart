import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/home/screean_tab_enum.dart';
import 'package:heart_beat/presentation/home/state/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeStateNotifire = StateNotifierProvider<HomeStateNotifire, HomeState>(
    ((ref) => HomeStateNotifire(ref)));

class HomeStateNotifire extends StateNotifier<HomeState> {
  HomeStateNotifire(
    this._ref,
  ) : super(const HomeState(
          currentTab: ScreenTab.bluetooth,
        )) {
    init();
  }

  final Ref _ref; //後で使うかもだから置いとく

  late StreamSubscription<List<ScanResult>> _subscription;

  Future<void> init() async {
    // maybe I'll add function that can chose which screan you open first
    // ah, and also I wanna make a function that can change language with setting
    // it would be interesting to make something like that :)
    // 言語変えられる設定とかできたら良さそう 日本語英語韓国語フランス語
  }

  void onChangeTab(BuildContext context, int currentIndex) {
    final currentTab =
        ScreenTab.values.firstWhere((element) => element.index == currentIndex);
    state = state.copyWith(
      currentTab: currentTab,
    );
  }
}
