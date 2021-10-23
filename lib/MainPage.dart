// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// import './BackgroundCollectedPage.dart';
import './BackgroundCollectingTask.dart';

// import './ChatPage.dart';
import './DiscoveryPage.dart';
// import './SelectBondedDevicePage.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask? _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "btpage",
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Image.asset('assets/images/bannar.png'),
          elevation: 0,
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: <Widget>[
              Divider(),
              Card(
                elevation: 0.5,
                child: SwitchListTile(
                  title: const Text('Enable Bluetooth'),
                  value: _bluetoothState.isEnabled,
                  onChanged: (bool value) {
                    // Do the request and update with the true value then
                    future() async {
                      // async lambda seems to not working
                      if (value)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();
                    }

                    future().then((_) {
                      setState(() {});
                    });
                  },
                ),
              ),
              Card(
                elevation: 0.5,
                child: ListTile(
                  title: const Text('Bluetooth status'),
                  subtitle: Text(_bluetoothState.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.settings),
                    color: Colors.grey[400],
                    iconSize: 32.0,
                    tooltip: 'Bluetooth Settings',
                    onPressed: () {
                      FlutterBluetoothSerial.instance.openSettings();
                    },
                  ),
                ),
              ),
              Card(
                elevation: 0.5,
                child: ListTile(
                    title: const Text('Local Device'),
                    subtitle: Text('name: $_name | address: $_address')),
              ),
              Card(
                elevation: 0.5,
                child: ListTile(
                  title: _discoverableTimeoutSecondsLeft == 0
                      ? const Text("Discoverable")
                      : Text(
                          "Discoverable for ${_discoverableTimeoutSecondsLeft}s"),
                  subtitle: const Text("Other devices can see your device"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _discoverableTimeoutSecondsLeft != 0,
                        onChanged: null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          print('Discoverable requested');
                          final int timeout = (await FlutterBluetoothSerial
                              .instance
                              .requestDiscoverable(60))!;
                          if (timeout < 0) {
                            print('Discoverable mode denied');
                          } else {
                            print(
                                'Discoverable mode acquired for $timeout seconds');
                          }
                          setState(() {
                            _discoverableTimeoutTimer?.cancel();
                            _discoverableTimeoutSecondsLeft = timeout;
                            _discoverableTimeoutTimer = Timer.periodic(
                                Duration(seconds: 1), (Timer timer) {
                              setState(() {
                                if (_discoverableTimeoutSecondsLeft < 0) {
                                  FlutterBluetoothSerial.instance.isDiscoverable
                                      .then((isDiscoverable) {
                                    if (isDiscoverable ?? false) {
                                      print(
                                          "Discoverable after timeout... might be infinity timeout :F");
                                      _discoverableTimeoutSecondsLeft += 1;
                                    }
                                  });
                                  timer.cancel();
                                  _discoverableTimeoutSecondsLeft = 0;
                                } else {
                                  _discoverableTimeoutSecondsLeft -= 1;
                                }
                              });
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              // Divider(),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: ElevatedButton(
                    child: const Text('Scan Bluetooth devices'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue[100],
                        onPrimary: Colors.blueGrey[900]),
                    onPressed: () async {
                      final BluetoothDevice? selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DiscoveryPage();
                          },
                        ),
                      );

                      if (selectedDevice != null) {
                        print(
                            'Discovery -> selected ' + selectedDevice.address);
                      } else {
                        print('Discovery -> no device selected');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
