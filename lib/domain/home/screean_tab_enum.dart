import 'package:flutter/material.dart';
import 'package:heart_beat/presentation/connected_device/screen/connected_device_screen.dart';
import 'package:heart_beat/presentation/graph/screen/graph_screen.dart';
import 'package:heart_beat/presentation/polar/screen/polar_screen.dart';
import 'package:heart_beat/presentation/scan/screen/scan_screen.dart';
import 'package:heart_beat/presentation/setting/screen/setting_screen.dart';

enum ScreenTab {
  bluetooth,
  polar,
  graph,
  setting,
}

extension ScreenTabEx on ScreenTab {
  String get tabTitle {
    switch (this) {
      case ScreenTab.bluetooth:
        return 'Bluetooth';
      case ScreenTab.polar:
        return 'Polar';
      case ScreenTab.graph:
        return 'Graph';
      case ScreenTab.setting:
        return 'Setting';
    }
  }

  String get tabScreen {
    switch (this) {
      case ScreenTab.bluetooth:
        return 'Connect to bluetooth deveice';
      case ScreenTab.polar:
        return 'Connect to polar deveice';
      case ScreenTab.graph:
        return 'Graph data';
      case ScreenTab.setting:
        return 'Setting';
    }
  }

  Widget get screen {
    switch (this) {
      case ScreenTab.bluetooth:
        return const ConnectedDeviceScreen();
      case ScreenTab.polar:
        return const PolarScreen();
      case ScreenTab.graph:
        return const GraphScreen();
      case ScreenTab.setting:
        return const SettingScreen();
    }
  }
}
