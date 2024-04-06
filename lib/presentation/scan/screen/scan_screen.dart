import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/scan/state_notifire/scan_state_notifire.dart';
import 'package:heart_beat/presentation/scan/widget/scan_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStateNotifireProvider =
        scanStateNotifire(SetItemChildProps(context));
    final scanResults = ref
        .watch(scanStateNotifireProvider.select((value) => value.scanResults));

    print('-----？？-----');
    print(scanResults);

    return Scaffold(
      appBar: AppBar(
        title: const Text('searh new devices'),
        backgroundColor: const Color.fromRGBO(218, 159, 255, 0.217),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(scanStateNotifireProvider.notifier).getScanResult();
        },
        child: scanResults.isNotEmpty
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  // final scanResult = scanResults[index];
                  return Column(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          height: 10,
                        ),
                      const DeviceInfo(
                          // scanResult: scanResult,
                          ),
                    ],
                  );
                },
              )
            : const _NoData(),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 100,
            color: Color.fromARGB(125, 0, 0, 0),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'no data',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(125, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(218, 159, 255, 0.217),
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await ref
                  .read(scanStateNotifireProvider.notifier)
                  .getScanResult();
              // await presenter.fetchIdentifier();
            },
            child: const Text(
              'reload',
              style: TextStyle(
                color: Color.fromARGB(140, 0, 0, 0),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              print('押されました');
              await ref
                  .read(scanStateNotifireProvider.notifier)
                  .requestPermisision();
            },
            child:
                Text('You may need premissions. \nPress here to Authorize it?'),
          ),
        ],
      ),
    );
  }
}
