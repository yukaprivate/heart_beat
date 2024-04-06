import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({
    required this.scanResult,
    super.key,
  });

  final ScanResult scanResult;

  @override
  Widget build(BuildContext context) {
    if (!scanResult.advertisementData.connectable) {
      return const SizedBox();
    }
    print(scanResult.advertisementData);
    // print(scanResult.advertisementData.serviceUuids.first.str);
    final tmp = ScanResult(
      device: BluetoothDevice(
        remoteId: DeviceIdentifier('a'),
      ),
      advertisementData: AdvertisementData(
        advName: "advName",
        txPowerLevel: 1,
        connectable: true,
        manufacturerData: {},
        serviceData: {},
        serviceUuids: [],
        appearance: null,
      ),
      rssi: 1,
      timeStamp: DateTime.now(),
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'デバイス名',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(tmp.advertisementData.advName),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'UUID',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text('777777777'),
                        // Text(tmp.advertisementData.serviceUuids.first.str),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () => tmp.device.connect(),
                  child: const Text('Connect'),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
      ],
    );
  }
}
