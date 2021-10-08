import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    Key? key,
    required WebSocketChannel channel,
    required this.switchState,
  })  : _channel = channel,
        super(key: key);

  final WebSocketChannel _channel;
  final String switchState;

  @override
  Widget build(BuildContext context) {
    Color switchColor = (switchState == 'OFF') ? Colors.green : Colors.red;
    return GestureDetector(
      onTap: () {
        String ss = (switchState == 'OFF') ? 'H' : 'L';
        _channel.sink.add(ss);
        //print('Hey');
      },
      child: Container(
        child: Center(
          child: Text(
            (switchState == 'OFF') ? 'ON' : 'OFF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
          color: switchColor,
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              switchColor.withOpacity(0.4),
              switchColor.withOpacity(0.7),
              switchColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 7,
              blurRadius: 17,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
