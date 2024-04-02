import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/scan/state_notifire/scan_state_notifire.dart';
import 'package:heart_beat/presentation/scan/widget/scan_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// BlocBuilderでstateの更新を読み取るのよりも、
// riverpodを使ってstateの更新を読み取る方が個人的に良い気がする....

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  // Future<void> initialize() async {
  //   _scanResults = (await startScanWithResult());

  //   // これは何のためのもの？
  //   _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
  //     _isScanning = state;
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  // Future<void> nannde() async {
  //   List<ScanResult> output = [];
  //   var subscription = FlutterBluePlus.scanResults.listen((result) {
  //     print('5');
  //     print(result);
  //     output = result;
  //   }, onError: (e, stackTrace) {
  //     print('6');
  //     throw Exception(e);
  //   });
  // }

  // static Future<List<ScanResult>> startScanWithResult({
  //   List<Guid> withServices = const [],
  //   Duration? timeout,
  //   bool androidUsesFineLocation = false,
  // }) async {
  //   if (FlutterBluePlus.isScanningNow) {
  //     throw Exception("Another scan is already in progress");
  //   }
  //   // スキャン結果を格納するリスト
  //   List<ScanResult> output = [];

  //   // スキャンのリスナーを設定し、結果をリストに追加する
  //   var subscription = FlutterBluePlus.scanResults.listen((result) {
  //     output.addAll(result);
  //   }, onError: (e, stackTrace) {
  //     throw Exception(e);
  //   });

  //   try {
  //     // スキャンを開始する
  //     await FlutterBluePlus.startScan(
  //       withServices: withServices,
  //       timeout: const Duration(seconds: 10),
  //       removeIfGone: null,
  //       oneByOne: false,
  //       androidUsesFineLocation: androidUsesFineLocation,
  //     );
  //     // スキャンが完了するまで待機する
  //     await Future.delayed(const Duration(seconds: 10));
  //   } finally {
  //     // スキャンを停止する
  //     await FlutterBluePlus.stopScan();

  //     // リスナーをキャンセルする
  //     await subscription.cancel();
  //   }
  //   // 完了したスキャン結果を返す
  //   return output;
  // }

  // @override
  // void dispose() {
  //   _scanResultsSubscription.cancel();
  //   _isScanningSubscription.cancel();
  //   super.dispose();
  // }

  // Future onScanPressed() async {
  //   try {
  //     _systemDevices = await FlutterBluePlus.systemDevices;
  //   } catch (e) {
  //     // Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
  //     //     success: false);
  //   }
  //   try {
  //     await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  //   } catch (e) {
  //     // Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
  //     //     success: false);
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // Future onStopPressed() async {
  //   try {
  //     FlutterBluePlus.stopScan();
  //   } catch (e) {
  //     // Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
  //     //     success: false);
  //   }
  // }

  // void onConnectPressed(BluetoothDevice device) {
  //   // device.connectAndUpdateStream().catchError((e) {
  //   //   Snackbar.show(ABC.c, prettyException("Connect Error:", e),
  //   //       success: false);
  //   // });
  //   // MaterialPageRoute route = MaterialPageRoute(
  //   //     builder: (context) => DeviceScreen(device: device),
  //   //     settings: RouteSettings(name: '/DeviceScreen'));
  //   // Navigator.of(context).push(route);
  // }

  // Future onRefresh() {
  //   if (_isScanning == false) {
  //     FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   return Future.delayed(Duration(milliseconds: 500));
  // }

  // Widget buildScanButton(BuildContext context) {
  //   if (FlutterBluePlus.isScanningNow) {
  //     return FloatingActionButton(
  //       child: const Icon(Icons.stop),
  //       onPressed: onStopPressed,
  //       backgroundColor: Colors.red,
  //     );
  //   } else {
  //     return FloatingActionButton(
  //         child: const Text("SCAN"), onPressed: onScanPressed);
  //   }
  // }

  List<Widget> _buildSystemDeviceTiles(
    BuildContext context,
    List<String> scanResults,
  ) {
    return scanResults
        .map(
          (d) => Text('$d'),
          // SystemDeviceTile(
          //   device: d,
          //   onOpen: () => Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DeviceScreen(device: d),
          //       settings: RouteSettings(name: '/DeviceScreen'),
          //     ),
          //   ),
          //   onConnect: () => onConnectPressed(d),
          // ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(
    BuildContext context,
    List<ScanResult> scanResults,
  ) {
    return scanResults
        .map(
          (r) => Text('${r}'
              // onTap: () => onConnectPressed(r.device),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStateNotifireProvider =
        scanStateNotifire(SetItemChildProps(context));
    final scanResults = ref
        .watch(scanStateNotifireProvider.select((value) => value.scanResults));

    print('-----？？-----');
    print(scanResults);

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blue tooth devices'),
          // title: const Text('initialize Polar Devices'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: scanResults.isNotEmpty
              ? ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    final scanResult = scanResults[index];
                    return Column(
                      children: [
                        DeviceInfo(
                          scanResult: scanResult,
                        ),
                      ],
                    );
                  },
                )
              : const _NoData(),
        ),
      ),
    );
  }
}

/// 表示するデータがない場合
class _NoData extends ConsumerWidget {
  const _NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStateNotifireProvider =
        scanStateNotifire(SetItemChildProps(context));
    final status =
        ref.watch(scanStateNotifireProvider.select((value) => value.status));

    // 名前おかしいな
    if (status == LoadingStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          backgroundColor: Color.fromARGB(237, 192, 187, 187),
        ),
      );
    }

    return Center(
      child: Column(
        children: [
          const Text('no data'),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () async {
              await ref
                  .read(scanStateNotifireProvider.notifier)
                  .requestPermisision();
            },
            child: const Text('Authorization'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () async {
              await ref
                  .read(scanStateNotifireProvider.notifier)
                  .getScanResult();
              // await presenter.fetchIdentifier();
            },
            child: const Text('reload'),
          ),
        ],
      ),
    );
  }
}
