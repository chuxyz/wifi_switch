import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'components/control_button.dart';
import 'components/control_switch.dart';

class SwitchScreen extends StatefulWidget {
  static String routeID = 'switch_screen';

  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  late WebSocketChannel _channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WiFi Switch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                print(snapshot.data);
                return (snapshot.hasData)
                    ? Column(
                        children: [
                          Icon(
                            (snapshot.data == 'OFF')
                                ? Icons.power_off
                                : Icons.power ,
                            size: 100.0,
                            color: (snapshot.data == 'OFF')
                                ? Colors.grey
                                : Colors.yellow.shade700,
                          ),
                          SizedBox(height: 30.0),
                          ControlSwitch(
                            channel: _channel,
                            switchState: '${snapshot.data}',
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _channel = WebSocketChannel.connect(Uri.parse("ws://192.168.4.1/ws"));
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
