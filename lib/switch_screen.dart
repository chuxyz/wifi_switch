import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'components/control_switch.dart';

class SwitchScreen extends StatefulWidget {
  static String routeID = 'switch_screen';

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  late WebSocketChannel _channel;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    _channel = WebSocketChannel.connect(Uri.parse("ws://192.168.4.1/ws"));
    double mediaHeight = MediaQuery.of(context).size.height;
    print(mediaHeight);
    return Scaffold(
      appBar: AppBar(
        title: Text('WiFi Switch'),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return (!snapshot.hasData &&
                        _connectivityResult == ConnectivityResult.wifi)
                    ? Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.wifi_rounded,
                              color: Colors.green,
                            ),
                            title: Text(
                              'Connected',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: mediaHeight * 0.2),
                          // Icon(
                          //   (snapshot.data == 'OFF')
                          //       ? Icons.power_off
                          //       : Icons.bolt_rounded,
                          //   size: mediaHeight * 0.29,
                          //   color: (snapshot.data == 'OFF')
                          //       ? Colors.grey
                          //       : Colors.orangeAccent,
                          // ),
                          (snapshot.data == 'ON')
                              ? Center(
                                  child: Container(
                                    height: 120.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.orange.shade800,
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: HeartbeatProgressIndicator(
                                      startScale: 0.9,
                                      endScale: 1.0,
                                      duration: Duration(seconds: 5),
                                      child: Image(
                                        image: AssetImage(
                                          'images/motor.png',
                                        ),
                                        color: Colors.green,
                                        width: 200,
                                        height: 80,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    height: 120.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red.shade800,
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                        'images/motor.png',
                                      ),
                                      color: Colors.grey,
                                      width: 200,
                                      height: 80,
                                    ),
                                  ),
                                ),
                          SizedBox(height: mediaHeight * 0.044),
                          ControlSwitch(
                            channel: _channel,
                            switchState: '${snapshot.data}',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: mediaHeight * 0.15),
                          Icon(
                            Icons.wifi_off_rounded,
                            size: mediaHeight * 0.44,
                            color: Colors.blueGrey.withOpacity(0.5),
                          ),
                          Text('WiFi is not connected.'),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Connect to WiFi: '),
                              Text(
                                'WiFiSwitch,',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_channel = WebSocketChannel.connect(Uri.parse("ws://192.168.4.1/ws"));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
    _connectivitySubscription.cancel();
  }
}
