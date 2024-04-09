import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/common/screen/widget/circle_icon.dart';
import 'package:heart_beat/presentation/scan/screen/scan_screen.dart';
import 'package:heart_beat/presentation/scan/state_notifire/scan_state_notifire.dart';
import 'package:heart_beat/presentation/scan/widget/scan_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectedDeviceScreen extends ConsumerWidget {
  const ConnectedDeviceScreen({super.key});

  bool get hasConnecteDevice => false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStateNotifireProvider =
        scanStateNotifire(SetItemChildProps(context));
    final scanResults = ref
        .watch(scanStateNotifireProvider.select((value) => value.scanResults));

    print('-----？？-----');
    print(scanResults);

    return Container(
      margin: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Connected Device',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(10, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: hasConnecteDevice
                  ? [
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: CircleIcon(
                          icon: Icons.bluetooth,
                          color: Color.fromRGBO(218, 159, 255, 0.217),
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'device name',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ),
                    ]
                  : [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          'No connected Device',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(126, 58, 58, 58),
                          ),
                        ),
                      ),
                    ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print('押されました');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const ScanScreen()),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text(
                    'search new devices',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'To connect BlueTooth, you need to use actual device, not simulator',
                        ),
                        Text(
                          'Bluetoothに接続するには、スマホ実機が必要です。',
                        ),
                        Text(
                          'I just realized that you cannnot use this func with AWS anplify ><',
                        ),
                        Text(
                          'あ、、、AWS anplify で見れない。。。？😅',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(),
          //   onPressed: () async {
          //     await ref
          //         .read(scanStateNotifireProvider.notifier)
          //         .requestPermisision();
          //   },
          //   child: const Text('Authorization'),
          // ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(),
          //   onPressed: () async {
          //     await ref
          //         .read(scanStateNotifireProvider.notifier)
          //         .getScanResult();
          //     // await presenter.fetchIdentifier();
          //   },
          //   child: const Text('reload'),
          // ),
        ],
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
