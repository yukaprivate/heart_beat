import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../injector.dart';
import '../presenter/scan_screen_presenter.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // List<BluetoothDevice> _systemDevices = [];
  // List<ScanResult> _scanResults = [];
  // bool _isScanning = false;
  // late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  // late StreamSubscription<bool> _isScanningSubscription;
  final presenter = injector.get<ScanScrennPresenter>();

  @override
  void initState() {
    super.initState();

    print('初め');

    presenter.onInitState();
  }

  @override
  void dispose() {
    super.dispose();
    presenter.dispasePage();
  }

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
  Widget build(BuildContext context) {
    // return ScaffoldMessenger(
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Find Devices'),
    //       ),
    //       body: RefreshIndicator(
    //         onRefresh: onRefresh,
    //         child: ListView(
    //           children: <Widget>[],
    //         ),
    //       ),
    //       floatingActionButton: Text('Hekko'),
    //     ),
    //   );
    // if (widget.isLoading) {
    //   return ScaffoldMessenger(
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Find Devices'),
    //       ),
    //       body: RefreshIndicator(
    //         onRefresh: onRefresh,
    //         child: ListView(
    //           children: <Widget>[],
    //         ),
    //       ),
    //       floatingActionButton: Text('Hekko'),
    //     ),
    //   );
    // }
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('initialize Polar Devices'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: presenter.state.identifier.isNotEmpty
              ? ListView(
                  children: <Widget>[
                    ..._buildSystemDeviceTiles(
                      context,
                      presenter.state.identifier,
                    ),
                    // ..._buildScanResultTiles(
                    //   context,
                    //   presenter.state.scanResults,
                    // ),
                  ],
                )
              : _NoData(),
        ),
      ),
    );
  }

  Container _NoData() {
    return Container(
      child: Column(
        children: [
          Text('何もありません'),
          ElevatedButton(
            child: const Text('色々権限付与したイオ'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: () async {
              await presenter.requestPermisision();
            },
          ),
          ElevatedButton(
            child: const Text('再度読み込みたいな！'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: () async {
              await presenter.fetchIdentifier();
            },
          ),
        ],
      ),
    );
  }
}
