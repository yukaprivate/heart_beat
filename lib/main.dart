// Copyright 2017-2023, Charles Weinberger & Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:heart_beat/presentation/scan/screen/scan_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'injector.dart';

// import 'screens/bluetooth_off_screen.dart';
// import 'screens/scan_screen.dart';

void main() {
  setupLocator();
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(const FlutterBlueApp());
}

//
// This widget shows BluetoothOffScreen or
// ScanScreen depending on the adapter state
//
class FlutterBlueApp extends StatefulWidget {
  const FlutterBlueApp({Key? key}) : super(key: key);

  @override
  State<FlutterBlueApp> createState() => _FlutterBlueAppState();
}

class _FlutterBlueAppState extends State<FlutterBlueApp> {
  // BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  // late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    // a();
    // _adapterStateStateSubscription =
    //     FlutterBluePlus.adapterState.listen((state) {
    //   _adapterState = state;
    //   if (mounted) {
    //     setState(() {});
    //   }
    //   GetIt.I.registerSingleton(MainPresenter());
    // });

    // var subscription = FlutterBluePlus.onScanResults.listen(
    //   (results) {
    //     if (results.isNotEmpty) {
    //       ScanResult r = results.last; // the most recently found device
    //       print(
    //           '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
    //     }
    //   },
    //   onError: (e) {
    //     print('ここここk');
    //     print(e);
    //   },
    // );

// cleanup: cancel subscription when scanning stops
    // FlutterBluePlus.cancelWhenScanComplete(subscription);
  }

  // Future<void> a() async {
  //   await Permission.location.request();
  //   await Permission.bluetooth.request();
  // }

  @override
  void dispose() {
    // _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: const ScanScreen(),
      navigatorObservers: [BluetoothAdapterStateObserver()],
    );
  }
}

//
// This observer listens for Bluetooth Off and dismisses the DeviceScreen
//
class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/DeviceScreen') {
      // Start listening to Bluetooth state changes when a new route is pushed
      _adapterStateSubscription ??=
          FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          // Pop the current route if Bluetooth is off
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // Cancel the subscription when the route is popped
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = null;
  }
}
