import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ControlSwitch extends StatelessWidget {
  const ControlSwitch({
    Key? key,
    required WebSocketChannel channel,
    required this.switchState,
  })  : _channel = channel,
        super(key: key);

  final WebSocketChannel _channel;
  final String switchState;

  @override
  Widget build(BuildContext context) {
    //Color switchColor = (switchState == 'OFF') ? Colors.green : Colors.red;
    bool isSwitched = (switchState == 'OFF') ? false : true;
    return FlutterSwitch(
      value: isSwitched,
      onToggle: (value) {
        String switchLevel = value ? 'H' : 'L';
        _channel.sink.add(switchLevel);
      },
      width: 125.0,
      height: 55.0,
      valueFontSize: 25.0,
      toggleSize: 45.0,
      borderRadius: 30.0,
      padding: 8.0,
      showOnOff: true,
    );
  }
}

/*

Transform.scale(
      scale: 6.0,
      child: Switch(
        activeColor: Colors.green,
        activeTrackColor: Colors.greenAccent,
        inactiveTrackColor: Colors.redAccent.withOpacity(0.5),
        inactiveThumbColor: Colors.red,
        value: isSwitched,
        onChanged: (value) {
          String switchLevel = value ? 'H' : 'L';
          _channel.sink.add(switchLevel);
        },
      ),
    )

*/