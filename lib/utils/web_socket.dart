
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket {
  final String wsHost = 'ws://192.168.4.1';
  void wsConnect() {
    final channel = WebSocketChannel.connect(Uri.parse(wsHost));
  }
}
