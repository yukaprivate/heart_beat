import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/scan/state/screen_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:polar/polar.dart';

// class MainEntities {
//   MainEntities({
//     required this.identifier,
//     required this.polar,
//     this.isLoading = true,
//   });

//   List<String> identifier;
//   final Polar polar;
//   bool isLoading;
// }

class ScanScrennPresenter extends Cubit<ScreenState> {
  ScanScrennPresenter()
      : super(ScreenState(
          scanResults: [],
          identifier: [],
          polar: Polar(),
          isLoading: true,
          status: LoadingStatus.initial,
        ));
  late StreamSubscription<List<ScanResult>> _subscription;
  late StreamSubscription<PolarBatteryLevelEvent> _streamFetchId;
  late StreamSubscription<PolarDeviceInfo> _streamPolarDeviceInfo;

  Future<void> onInitState() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      await requestPermisision();
      await fetchIdentifier();
    } catch (e) {
      emit(state.copyWith(
        status: LoadingStatus.faild,
      ));
    } finally {
      emit(state.copyWith(
        isLoading: false,
        status: LoadingStatus.success,
      ));
    }
  }

  Future<void> requestPermisision() async {
    final storagePermission = await Permission.storage.status;
    if (storagePermission != PermissionStatus.granted) {
      await Permission.storage.request();
    }
    final bluetoothPermission = await Permission.bluetooth.status;
    if (bluetoothPermission != PermissionStatus.granted) {
      await Permission.bluetooth.request();
    }
    final bluetoothAdvertisePermission =
        await Permission.bluetoothAdvertise.status;
    if (bluetoothAdvertisePermission != PermissionStatus.granted) {
      await Permission.bluetoothAdvertise.request();
    }
    final bluetoothConnectPermission = await Permission.bluetoothConnect.status;
    if (bluetoothConnectPermission != PermissionStatus.granted) {
      await Permission.bluetoothConnect.request();
    }
    final bluetoothScanPermission = await Permission.bluetoothScan.status;
    if (bluetoothScanPermission != PermissionStatus.granted) {
      await Permission.bluetoothScan.request();
    }
  }

  Future<void> fetchIdentifier() async {
    List<String> identifiers = [];
    List<PolarDeviceInfo> polarDeviceInfos = [];
    try {
      if (FlutterBluePlus.isScanningNow) {
        throw Exception("Another scan is already in progress");
      }
      // スキャン結果を格納するリスト
      print('ここきた');

      // スキャンのリスナーを設定し、結果をリストに追加する
      _streamFetchId = state.polar.batteryLevel.listen((event) {
        final aa = [...state.identifier];
        aa.add(event.identifier);
        print('aa------$aa');
        emit(state.copyWith(
          identifier: aa,
        ));
      });

      // final aaaa = state.polar.connectToDevice(state.identifier[0]);

      // _streamPolarDeviceInfo = state.polar.searchForDevice().listen((event) {
      //   final aa = [...state.identifier];
      //   aa.add(event.deviceId);
      //   emit(state.copyWith(
      //     identifier: aa,
      //   ));
      // });
    } finally {
      // リスナーをキャンセルする
      // await _streamFetchId.cancel();
      // await _streamPolarDeviceInfo.cancel();
    }
    // 完了したスキャン結果を返す
    // print('----------けっか');
    // print(identifiers);
    // print(polarDeviceInfos);
    // emit(state.copyWith(
    //   identifier: identifiers,
    // ));
  }

  Future<void> dispasePage() async {
    // リスナーをキャンセルする
    await _streamFetchId.cancel();
    await _streamPolarDeviceInfo.cancel();
  }

  // せっかく書いたから消したくない
  // Future<void> getScanResult() async {
  //   List<ScanResult> output = [];
  //   try {
  //     if (FlutterBluePlus.isScanningNow) {
  //       throw Exception("Another scan is already in progress");
  //     }
  //     // スキャン結果を格納するリスト

  //     // スキャンのリスナーを設定し、結果をリストに追加する
  //     _subscription = FlutterBluePlus.scanResults.listen((result) {
  //       output.addAll(result);
  //     }, onError: (e, stackTrace) {
  //       throw Exception(e);
  //     });

  //     // スキャンを開始する
  //     await FlutterBluePlus.startScan(
  //       withServices: [],
  //       timeout: const Duration(seconds: 10),
  //       removeIfGone: null,
  //       oneByOne: false,
  //       androidUsesFineLocation: false,
  //     );
  //     // スキャンが完了するまで待機する
  //     await Future.delayed(const Duration(seconds: 10));
  //   } finally {
  //     // スキャンを停止する
  //     await FlutterBluePlus.stopScan();
  //     // リスナーをキャンセルする
  //     await _subscription.cancel();
  //   }
  //   // 完了したスキャン結果を返す
  //   print(output);
  //   emit(state.copyWith(
  //     scanResults: output,
  //   ));
  // }

  Future<void> onInitPagetmp() async {
    // var subscription = flutterBlue.scanResults.listen((results) {
    //   print('きてる？');
    //   print(results);
    //   // do something with scan results
    //   for (ScanResult r in results) {
    //     print('${r.device.name} found! rssi: ${r.rssi}');
    //   }
    // });
    // print('ナニコレ');
    // print(subscription);

    // final identifier =
    //     polar.batteryLevel.first.then((value) => print(value.identifier));
    print('ここきてる？');
    final batteryLevels = await state.polar.batteryLevel.map((e) => e).toList();
    final identifiers = await Future.wait(batteryLevels.map((event) async {
      return event.identifier;
    }));

    print('ここきてる？');

    for (final a in identifiers) {
      print(a);
    }

    // state.identifier = identifiers;

    state.polar.batteryLevel.listen((e) => print('Battery: ${e.level}'));
    state.polar.deviceConnecting.listen((_) => print('Device connecting'));
    state.polar.deviceConnected.listen((_) => print('Device connected'));
    state.polar.deviceDisconnected.listen((_) => print('Device disconnected'));
  }
}
