import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/common/screen/widget/dialog/common_dialog.dart';
import 'package:heart_beat/presentation/scan/state/screen_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:polar/polar.dart';

class SetItemChildProps extends Equatable {
  const SetItemChildProps(
    this.context,
  );
  final BuildContext context;

  @override
  List<Object?> get props => [
        context,
      ];
}

final scanStateNotifire = StateNotifierProvider.family<
        ScanStateNotifire, ScreenState, SetItemChildProps>(
    ((ref, props) => ScanStateNotifire(
          ref,
          props.context,
        )));

class ScanStateNotifire extends StateNotifier<ScreenState> {
  ScanStateNotifire(
    this._ref,
    this._context,
  ) : super(ScreenState(
          scanResults: [],
          identifier: [],
          polar: Polar(),
          isLoading: true,
          status: LoadingStatus.initial,
        )) {
    init();
  }

  final Ref _ref; //後で使うかもだから置いとく

  final BuildContext _context;

  late StreamSubscription<List<ScanResult>> _subscription;

  Future<void> init() async {
    requestPermisision();
    getScanResult();
  }

  Future<void> requestPermisision() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
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
    try {
      if (FlutterBluePlus.isScanningNow) {
        _showFaildDialog('Another scan is already in progress');
        throw Exception("Another scan is already in progress");
      }
      // スキャン結果を格納するリスト
      print('ここきた');

      // スキャンのリスナーを設定し、結果をリストに追加する
      // _streamFetchId = state.polar.batteryLevel.listen((event) {
      //   final aa = [...state.identifier];
      //   aa.add(event.identifier);
      //   print('aa------$aa');
      //   emit(state.copyWith(
      //     identifier: aa,
      //   ));
      // });

      // final aaaa = state.polar.connectToDevice(state.identifier[0]);

      state.polar.searchForDevice().listen((event) {
        state = state.copyWith(
          identifier: [...state.identifier],
        );
      });
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

  Future<void> getScanResult() async {
    List<ScanResult> output = [];
    StreamSubscription<List<ScanResult>>? streamSubscription;
    try {
      state = state.copyWith(
        status: LoadingStatus.loading,
      );
      if (FlutterBluePlus.isScanningNow) {
        throw Exception("Another scan is already in progress");
      }
      // スキャン結果を格納するリスト

      // スキャンのリスナーを設定し、結果をリストに追加する
      _subscription = FlutterBluePlus.onScanResults.listen((result) {
        output.addAll(result);
        print(output);
      }, onError: (e, stackTrace) {
        _showFaildDialog('faild to scan');
        throw Exception(e);
      });

      // スキャンを開始する
      await FlutterBluePlus.startScan(
        withServices: [],
        timeout: const Duration(seconds: 10),
        removeIfGone: null,
        oneByOne: false,
        androidUsesFineLocation: false,
      );
      // スキャンが完了するまで待機する
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      // state更新
      state = state.copyWith(
        status: LoadingStatus.success,
        scanResults: output,
      );
      print(state.scanResults);
      // スキャンを停止する
      await FlutterBluePlus.stopScan();
      // リスナーをキャンセルする
      await _subscription.cancel();
      // await streamSubscription?.cancel();
      // 完了したスキャン結果を返す
    }
  }

  void _showFaildDialog(String message) {
    showDialog(
      context: _context,
      builder: (context) => CommonDialog(
        child: Text(message),
      ),
    );
  }
}
