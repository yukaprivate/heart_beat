import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_beat/domain/home/screean_tab_enum.dart';
import 'package:heart_beat/domain/scan/enum/loading_status_enum.dart';
import 'package:heart_beat/presentation/connected_device/screen/connected_device_screen.dart';
import 'package:heart_beat/presentation/scan/screen/scan_screen.dart';
import 'package:heart_beat/presentation/scan/state_notifire/scan_state_notifire.dart';
import 'package:heart_beat/presentation/scan/widget/scan_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state_notifire/home_state_notifire.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab =
        ref.watch(homeStateNotifire.select((value) => value.currentTab));
    // final provider = homeStateNotifire.notifier
    //     .select((value) => value.onChangeTab(context, value));

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentTab.tabScreen),
          backgroundColor: const Color.fromRGBO(218, 159, 255, 0.217),
        ),
        body: currentTab.screen,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            print(value);
            ref.read(homeStateNotifire.notifier).onChangeTab(context, value);
          },
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(218, 159, 255, 0.217),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bluetooth,
              ),
              label: 'Bluetooth',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Polar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.show_chart,
              ),
              label: 'Graph',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
